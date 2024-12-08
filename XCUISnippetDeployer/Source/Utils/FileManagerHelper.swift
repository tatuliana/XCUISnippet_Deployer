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
                let snippetDictionary: [String: Any] = [
                    "IDECodeSnippetCompletionPrefix": snippet.title.lowercased().replacingOccurrences(of: " ", with: ""),
                    "IDECodeSnippetCompletionScopes": ["All"], // Adjust as needed
                    "IDECodeSnippetContents": snippet.content,
                    "IDECodeSnippetIdentifier": uuid,
                    "IDECodeSnippetLanguage": "Xcode.SourceCodeLanguage.Swift",
                    "IDECodeSnippetSummary": snippet.description,
                    "IDECodeSnippetTitle": snippet.title,
                    "IDECodeSnippetUserSnippet": true,
                    "IDECodeSnippetVersion": 2
                ]

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
}
