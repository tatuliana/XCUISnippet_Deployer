//
//  FileManagerHelper.swift
//  XCUISnippetDeployer
//
//  Created by Natalia Popova on 12/7/24.
//

import Foundation

class FileManagerHelper {
    static func save(snippets: [Snippet], pattern: SnippetPattern) {
        let xcodeSnippetsDirectory = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Developer/Xcode/UserData/CodeSnippets")

        do {
            try FileManager.default.createDirectory(at: xcodeSnippetsDirectory, withIntermediateDirectories: true, attributes: nil)

            if hasLegacySnippets(in: xcodeSnippetsDirectory, matching: snippets) {
                print("Legacy v1.0 snippets detected for '\(pattern.rawValue)'.")
                print("Would you like to delete them and proceed with deployment? (y/n)")
                guard readLine()?.lowercased() == "y" else {
                    print("Deployment cancelled. Use option 4 to delete legacy snippets first.")
                    return
                }
                removeLegacySnippets(in: xcodeSnippetsDirectory, matching: snippets)
                guard !hasLegacySnippets(in: xcodeSnippetsDirectory, matching: snippets) else {
                    print("Failed to remove all legacy snippets. Close Xcode and try again, or use option 4 to delete them manually.")
                    return
                }
                print("Legacy snippets deleted. Proceeding with deployment...")
            }

            let existingSnippets = loadExistingSnippets(from: xcodeSnippetsDirectory, for: pattern)
            if !existingSnippets.isEmpty {
                print("Snippets for '\(pattern.rawValue)' are already deployed. Use option 2 to update them instead.")
                return
            }

            for snippet in snippets {
                let uuid = UUID().uuidString
                let fileName = "\(uuid).codesnippet"
                let fileURL = xcodeSnippetsDirectory.appendingPathComponent(fileName)

                let snippetDictionary: [String: Any] = createSnippetDictionary(snippet: snippet, uuid: uuid, pattern: pattern)
                let data = try PropertyListSerialization.data(fromPropertyList: snippetDictionary, format: .xml, options: 0)
                try data.write(to: fileURL)
                print("Snippet \"\(pattern.titlePrefix) \(snippet.title)\" saved to \(fileURL.path).")
            }
        } catch {
            print("Failed to save snippets for pattern \(pattern.rawValue): \(error.localizedDescription)")
        }
    }

    static func update(snippets: [Snippet], pattern: SnippetPattern) {
        let xcodeSnippetsDirectory = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Developer/Xcode/UserData/CodeSnippets")

        do {
            if hasLegacySnippets(in: xcodeSnippetsDirectory, matching: snippets) {
                print("Legacy v1.0 snippets detected for '\(pattern.rawValue)'. Use option 4 to delete them first, then deploy with option 1.")
                return
            }

            let existingSnippets = loadExistingSnippets(from: xcodeSnippetsDirectory, for: pattern)
            if existingSnippets.isEmpty {
                print("No deployed snippets found for '\(pattern.rawValue)'. Use option 1 to deploy them first.")
                return
            }

            for snippet in snippets {
                let prefixedTitle = "\(pattern.titlePrefix) \(snippet.title)"
                do {
                    let uuid = UUID().uuidString
                    let fileName = "\(uuid).codesnippet"
                    let fileURL = xcodeSnippetsDirectory.appendingPathComponent(fileName)

                    let snippetDictionary: [String: Any] = createSnippetDictionary(snippet: snippet, uuid: uuid, pattern: pattern)
                    let data = try PropertyListSerialization.data(fromPropertyList: snippetDictionary, format: .xml, options: 0)
                    try data.write(to: fileURL)

                    if let existingFile = existingSnippets[prefixedTitle] {
                        try FileManager.default.removeItem(at: existingFile)
                    }
                    print("Snippet \"\(prefixedTitle)\" updated at \(fileURL.path).")
                } catch {
                    print("Failed to update snippet \"\(prefixedTitle)\": \(error.localizedDescription)")
                }
            }
        } catch {
            print("Failed to update snippets for pattern \(pattern.rawValue): \(error.localizedDescription)")
        }
    }

    static func delete(snippets: [Snippet], pattern: SnippetPattern) {
        let xcodeSnippetsDirectory = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Developer/Xcode/UserData/CodeSnippets")

        do {
            if hasLegacySnippets(in: xcodeSnippetsDirectory, matching: snippets) {
                print("Legacy v1.0 snippets detected for '\(pattern.rawValue)'. Use option 4 to delete them.")
                return
            }

            let existingSnippets = loadExistingSnippets(from: xcodeSnippetsDirectory, for: pattern)
            if existingSnippets.isEmpty {
                print("No deployed snippets found for '\(pattern.rawValue)'.")
                return
            }

            for snippet in snippets {
                let prefixedTitle = "\(pattern.titlePrefix) \(snippet.title)"
                if let existingFile = existingSnippets[prefixedTitle] {
                    try FileManager.default.removeItem(at: existingFile)
                    print("Snippet \"\(prefixedTitle)\" has been deleted.")
                } else {
                    print("Snippet \"\(prefixedTitle)\" not found.")
                }
            }
        } catch {
            print("Failed to delete snippets for pattern \(pattern.rawValue): \(error.localizedDescription)")
        }
    }

    static func deleteLegacy(snippets: [Snippet], pattern: SnippetPattern) {
        let xcodeSnippetsDirectory = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Developer/Xcode/UserData/CodeSnippets")

        guard hasLegacySnippets(in: xcodeSnippetsDirectory, matching: snippets) else {
            print("No legacy v1.0 snippets found for '\(pattern.rawValue)'.")
            return
        }

        removeLegacySnippets(in: xcodeSnippetsDirectory, matching: snippets)
        if hasLegacySnippets(in: xcodeSnippetsDirectory, matching: snippets) {
            print("Failed to remove all legacy snippets for '\(pattern.rawValue)'. Close Xcode and try again.")
        } else {
            print("Legacy snippets for '\(pattern.rawValue)' have been deleted. You can now use option 1 to deploy v2.0 snippets.")
        }
    }

    private static func hasLegacySnippets(in directory: URL, matching snippets: [Snippet]) -> Bool {
        let titles = legacyTitleSet(for: snippets)
        guard let files = try? FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: []) else { return false }
        return files.filter { $0.pathExtension == "codesnippet" }.contains { file in
            guard let data = try? Data(contentsOf: file),
                  let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
                  let title = plist["IDECodeSnippetTitle"] as? String else { return false }
            return plist["XCUIBuilderPattern"] == nil && titles.contains(title)
        }
    }

    private static func legacyTitleSet(for snippets: [Snippet]) -> Set<String> {
        let allTitleVariants: [String] = snippets.flatMap { snippet -> [String] in
            let numbered = snippet.title
            let unnumbered = snippet.title.replacingOccurrences(of: "^\\d+\\.\\s*", with: "", options: .regularExpression)
            let variants = numbered == unnumbered ? [numbered] : [numbered, unnumbered]
            let prefixed = SnippetPattern.allCases.flatMap { pattern in
                variants.map { "\(pattern.titlePrefix) \($0)" }
            }
            return variants + prefixed
        }
        return Set(allTitleVariants)
    }

    private static func removeLegacySnippets(in directory: URL, matching snippets: [Snippet]) {
        let titles = legacyTitleSet(for: snippets)
        guard let files = try? FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: []) else { return }
        for file in files where file.pathExtension == "codesnippet" {
            guard let data = try? Data(contentsOf: file),
                  let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
                  let title = plist["IDECodeSnippetTitle"] as? String,
                  plist["XCUIBuilderPattern"] == nil,
                  titles.contains(title) else { continue }
            do {
                try FileManager.default.removeItem(at: file)
                print("Deleted legacy snippet: \"\(title)\"")
            } catch {
                print("Failed to delete legacy snippet \"\(title)\": \(error.localizedDescription)")
            }
        }
    }

    private static func createSnippetDictionary(snippet: Snippet, uuid: String, pattern: SnippetPattern) -> [String: Any] {
        let prefixedTitle = "\(pattern.titlePrefix) \(snippet.title)"
        let cleanedTitle = snippet.title
            .lowercased()
            .replacingOccurrences(of: "\\d+\\.\\s*", with: "", options: .regularExpression)
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .joined()
        let completionPrefix = "\(pattern.shortCode).\(cleanedTitle)"

        return [
            "IDECodeSnippetCompletionPrefix": completionPrefix,
            "IDECodeSnippetCompletionScopes": ["All"],
            "IDECodeSnippetContents": snippet.content,
            "IDECodeSnippetIdentifier": uuid,
            "IDECodeSnippetLanguage": "Xcode.SourceCodeLanguage.Swift",
            "IDECodeSnippetSummary": snippet.description,
            "IDECodeSnippetTitle": prefixedTitle,
            "IDECodeSnippetUserSnippet": true,
            "IDECodeSnippetVersion": 2,
            "XCUIBuilderPattern": pattern.rawValue
        ]
    }

    private static func loadExistingSnippets(from directory: URL, for pattern: SnippetPattern) -> [String: URL] {
        var snippets = [String: URL]()
        do {
            let files = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: [])
            for file in files where file.pathExtension == "codesnippet" {
                if let data = try? Data(contentsOf: file),
                   let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
                   let title = plist["IDECodeSnippetTitle"] as? String,
                   let snippetPattern = plist["XCUIBuilderPattern"] as? String,
                   snippetPattern == pattern.rawValue {
                    snippets[title] = file
                }
            }
        } catch {
            print("Failed to load existing snippets: \(error.localizedDescription)")
        }
        return snippets
    }
}
