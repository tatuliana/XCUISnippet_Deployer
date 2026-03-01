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
            // Ensure the directory exists
            try FileManager.default.createDirectory(at: xcodeSnippetsDirectory, withIntermediateDirectories: true, attributes: nil)

            for snippet in snippets {
                // Generate a unique UUID for the snippet
                let uuid = UUID().uuidString
                let fileName = "\(uuid).codesnippet"
                let fileURL = xcodeSnippetsDirectory.appendingPathComponent(fileName)

                // Create the snippet dictionary in plist format
                let snippetDictionary: [String: Any] = createSnippetDictionary(snippet: snippet, uuid: uuid)

                // Convert dictionary to plist data
                let data = try PropertyListSerialization.data(fromPropertyList: snippetDictionary, format: .xml, options: 0)
                
                // Write plist data to file
                try data.write(to: fileURL)
                print("Snippet \"\(snippet.title)\" saved to \(fileURL.path).")
            }
        } catch {
            print("Failed to save snippets for pattern \(pattern.rawValue): \(error.localizedDescription)")
        }
    }
    
    static func update(snippets: [Snippet], pattern: SnippetPattern) {
        let xcodeSnippetsDirectory = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Developer/Xcode/UserData/CodeSnippets")

        do {
            try FileManager.default.createDirectory(at: xcodeSnippetsDirectory, withIntermediateDirectories: true, attributes: nil)

            let existingSnippets = loadExistingSnippets(from: xcodeSnippetsDirectory)

            for snippet in snippets {
                if let existingFile = existingSnippets[snippet.title] {
                    try FileManager.default.removeItem(at: existingFile)
                    print("Removed existing snippet with title: \(snippet.title)")
                }

                let uuid = UUID().uuidString
                let fileName = "\(uuid).codesnippet"
                let fileURL = xcodeSnippetsDirectory.appendingPathComponent(fileName)

                let snippetDictionary: [String: Any] = createSnippetDictionary(snippet: snippet, uuid: uuid)
                let data = try PropertyListSerialization.data(fromPropertyList: snippetDictionary, format: .xml, options: 0)

                try data.write(to: fileURL)
                print("Snippet \"\(snippet.title)\" updated at \(fileURL.path).")
            }
        } catch {
            print("Failed to update snippets for pattern \(pattern.rawValue): \(error.localizedDescription)")
        }
    }
    
    static func delete(snippets: [Snippet], pattern: SnippetPattern) {
            let xcodeSnippetsDirectory = FileManager.default.homeDirectoryForCurrentUser
                .appendingPathComponent("Library/Developer/Xcode/UserData/CodeSnippets")

            do {
                let existingSnippets = loadExistingSnippets(from: xcodeSnippetsDirectory)

                for snippet in snippets {
                    if let existingFile = existingSnippets[snippet.title] {
                        try FileManager.default.removeItem(at: existingFile)
                        print("Snippet \"\(snippet.title)\" has been deleted.")
                    } else {
                        print("Snippet \"\(snippet.title)\" not found.")
                    }
                }
            } catch {
                print("Failed to delete snippets for pattern \(pattern.rawValue): \(error.localizedDescription)")
            }
        }

    private static func createSnippetDictionary(snippet: Snippet, uuid: String) -> [String: Any] {
        return [
            "IDECodeSnippetCompletionPrefix": snippet.title.lowercased().replacingOccurrences(of: " ", with: ""),
            "IDECodeSnippetCompletionScopes": ["All"],
            "IDECodeSnippetContents": snippet.content,
            "IDECodeSnippetIdentifier": uuid,
            "IDECodeSnippetLanguage": "Xcode.SourceCodeLanguage.Swift",
            "IDECodeSnippetSummary": snippet.description,
            "IDECodeSnippetTitle": snippet.title,
            "IDECodeSnippetUserSnippet": true,
            "IDECodeSnippetVersion": 2
        ]
    }

    private static func loadExistingSnippets(from directory: URL) -> [String: URL] {
        var snippets = [String: URL]()
        do {
            let files = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: [])
            for file in files where file.pathExtension == "codesnippet" {
                if let data = try? Data(contentsOf: file),
                   let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
                   let title = plist["IDECodeSnippetTitle"] as? String {
                    snippets[title] = file
                }
            }
        } catch {
            print("Failed to load existing snippets: \(error.localizedDescription)")
        }
        return snippets
    }
}
