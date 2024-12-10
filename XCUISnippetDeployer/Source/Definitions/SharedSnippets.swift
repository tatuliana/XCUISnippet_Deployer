//
//  SharedSnippets.swift
//  XCUISnippetDeployer
//
//  Created by Natalia Popova on 12/9/24.
//

import Foundation

class SharedSnippets {
    static func getAll() -> [Snippet] {
        return [
            documentation(),
            testFunc(),
            stepActivity(),
            assertElementStateActivity(),
            assertEqualToActivity()
        ]
    }
    
    private static func documentation() -> Snippet {
        return Snippet(
            title: "Documentation",
            description: "Documentation template",
            content:
"""
/// Summary text for documentation
/// - parameter: <#Description#>
/// - parameter <#parameterName#>: <#Description#>
/// - returns: <#Return values#>
/// - warning: <#Warning if any#>
///
/// # Notes: #
///
/// - <#Notes if any#>
"""
        )
    }
    
    private static func testFunc() -> Snippet {
        return Snippet(
            title: "Test func",
            description: "Test function",
            content:
"""
func test<#TestName#>() {
    runActivity(named: "<#Test Description#>") {
        
    }
}
"""
        )
    }
    
    private static func stepActivity() -> Snippet {
        return Snippet(
            title: "Activity: Step",
            description: "Step Activity to describe interacions with UI Elements",
            content:
"""
runActivity(.step, "<#Step description#>") {

    <#code#>
}
"""
        )
    }
    
    private static func assertElementStateActivity() -> Snippet {
        return Snippet(
            title: "Activity: Assert State",
            description: "Activity to use in assertion for an element state",
            content:
"""
runActivity(element: "<#Element description#>", state: .<#ElementState#>, expected: result) {
    <#code#>
}
"""
        )
    }
    
    private static func assertEqualToActivity() -> Snippet {
        return Snippet(
            title: "Activity: Assert Equal to",
            description: "Activity to use in assertion for label, value or placeholderValue to be equal to expected result" ,
            content:
"""
runActivity(element: "<#Element description#>", property: .<#Properties#>, equalTo: "<#Expected Result#>", expected: result) {
    <#code#>
}
"""
        )
    }
}

