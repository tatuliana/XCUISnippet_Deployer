//
//  main.swift
//  XCUISnippetDeployer
//
//  Created by Natalia Popova on 12/7/24.
//

import Foundation

func main() {
    print("Welcome to XCUISnippetDeployer CLI Tool")
    print("Available Patterns:")
    for (index, pattern) in SnippetPattern.allCases.enumerated() {
        print("\(index + 1). \(pattern.rawValue)")
    }

    print("Select a pattern by entering its number:")
    guard let input = readLine(),
          let patternIndex = Int(input),
          patternIndex > 0 && patternIndex <= SnippetPattern.allCases.count else {
        print("Invalid input. Exiting.")
        return
    }

    let selectedPattern = SnippetPattern.allCases[patternIndex - 1]
    print("Selected Pattern: \(selectedPattern.rawValue)")

    let snippets = SnippetDefinitions.getSnippets(for: selectedPattern)
    FileManagerHelper.save(snippets: snippets, pattern: selectedPattern)
}

main()

