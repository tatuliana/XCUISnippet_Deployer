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
    
    print("""
        Please choose an option:
        1. Deploy snippets (initial deployment)
        2. Update snippets (replace existing ones if they have the same title)
        3. Delete previously deployed snippets
        """)
    
    guard let input = readLine() else {
        print("Invalid input. Exiting.")
        return
    }
    
    let snippets = SnippetDefinitions.getSnippets(for: selectedPattern) + SharedSnippets.getAll()
    
    switch input {
    case "1":
        print("Deploying snippets...")
        FileManagerHelper.save(snippets: snippets, pattern: selectedPattern)
        
    case "2":
        print("Updating snippets...")
        FileManagerHelper.update(snippets: snippets, pattern: selectedPattern)
        
    case "3":
        print("Deleting previously deployed snippets...")
        FileManagerHelper.delete(snippets: snippets, pattern: selectedPattern)
        
    default:
        print("Invalid input. Exiting.")
    }
}

main()

