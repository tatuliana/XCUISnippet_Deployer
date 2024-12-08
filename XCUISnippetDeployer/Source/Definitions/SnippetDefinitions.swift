//
//  SnippetDefinitions.swift
//  XCUISnippetDeployer
//
//  Created by Natalia Popova on 12/7/24.
//

import Foundation

class SnippetDefinitions {
    static func getSnippets(for pattern: SnippetPattern) -> [Snippet] {
        switch pattern {
        case .screenTransitionChaining:
            return ScreenTransitionChainingSnippets.getAll()
        case .selfChaining:
            return SelfChainingSnippets.getAll()
        }
    }
}
