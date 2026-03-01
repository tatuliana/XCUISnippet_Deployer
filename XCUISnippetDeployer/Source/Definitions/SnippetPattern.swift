//
//  SnippetPattern.swift
//  XCUISnippetDeployer
//
//  Created by Natalia Popova on 12/7/24.
//

import Foundation

enum SnippetPattern: String, CaseIterable {
    case screenTransitionChaining = "Screen Transition Chaining"
    case selfChaining = "Self-Chaining"

    var titlePrefix: String {
        switch self {
        case .screenTransitionChaining: return "[STC]"
        case .selfChaining: return "[SC]"
        }
    }

    var shortCode: String {
        switch self {
        case .screenTransitionChaining: return "stc"
        case .selfChaining: return "sc"
        }
    }
}
