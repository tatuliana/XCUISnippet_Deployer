//
//  SelfChainingSnippets.swift
//  XCUISnippetDeployer
//
//  Created by Natalia Popova on 12/7/24.
//

import Foundation

class SelfChainingSnippets {
    static func getAll() -> [Snippet] {
        return [
            tapElement(),
            tapElementAtIndex(),
            assertExists(),
            assertExistsAtIndex(),
            assertIsEnabled(),
            assertElementIsSelected(),
            enterText(),
            screenTemplate(),
            protocolTemplate(),
            assertElementState(),
            documentation()
        ]
    }
    
    private static func tapElement() -> Snippet {
        return Snippet(
            title: "Tap func",
            description: "Taps element and returns self for chaining.",
            content:
"""
/// Taps the `<#elementName#>`
/// - returns: Self. Returns self for the chaining purpose
@discardableResult
func tap<#ElementName#>() -> Self {
    runActivity(.step, "Tap the `<#elementName#>`") {
        <#elementName#>.tap()
        return self
    }
}
"""
        )
    }
    
    private static func tapElementAtIndex() -> Snippet {
        return Snippet(
            title: "Tap index func",
            description: "Taps element at index and returns self for chaining.",
            content:
"""
/// Taps the `<#elementQuery#>`
/// - parameter index: The index of the element to tap. Default is 0.
/// - returns: Self. Returns self for the chaining purpose
@discardableResult
func tap<#ElementQuery#>(index: Int = 0) -> Self {
    runActivity(.step, "Tap the `<#elementQuery#>` at index `\\(index)`") {
        <#elementQuery#>.element(boundBy: index).tap()
        return self
    }
}
"""
        )
    }
    
    private static func assertExists() -> Snippet {
        return Snippet(
            title: "Assert Exists func",
            description: "Asserts if the element exists. Returns self for chaining.",
            content:
"""
/// Verifies if the `<#elementName#>` exists.
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: Self. Returns self for the chaining purpose
/// - _Examples:_
///   - To verify the element exists:
///     ```swift
///        .assert<#ElementName#>Exists()
///     ```
///   - To verify the element doesn't exist:
///     ```swift
///        .assert<#ElementName#>Exists(expected: false)
///     ```
func assert<#ElementName#>Exists(expected result: Bool = true) -> Self {
    runActivity(element: "<#element description#>", state: .exists, expected: result) {
        <#elementName#>.assert(state: .exists, expected: result)
        return self
    }
}
"""
        )
    }
    
    private static func assertExistsAtIndex() -> Snippet {
        return Snippet(
            title: "Assert Exists at index func",
            description: "Asserts if the element at index exists. Returns self for chaining.",
            content:
"""
/// Verifies if the `<#ElementQuery#>` at index exists.
/// - parameter index: The index of the element to verify. Default is 0.
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: Self. Returns self for the chaining purpose
/// - _Examples:_
///   - To verify the element at index 3 exists:
///     ```swift
///        .assert<#ElementQuery#>Exists(index: 3)
///     ```
///   - To verify the element at index 5 doesn't exist:
///     ```swift
///        .assert<#ElementQuery#>Exists(index: 5, expected: false)
///     ```
func assert<#ElementQuery#>Exists(index: Int = 0, expected result: Bool = true) -> Self {
    runActivity(element: "<#element description#> at \\(index)", state: .exists, expected: result) {
        <#elementQuery#>.assert(state: .exists, expected: result)
        return self
    }
}
"""
        )
    }
    
    private static func assertIsEnabled() -> Snippet {
        return Snippet(
            title: "Assert Enabled func",
            description: "Asserts if the element is enabled. Returns self for chaining.",
            content:
"""
/// Asserts if the `<#elementName#>` is enabled.
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: Self. Returns self for the chaining purpose
/// - _Examples:_
///   - To verify the element is enabled:
///     ```swift
///        .assert<#ElementName#>IsEnabled()
///     ```
///   - To verify the element is not enabled:
///     ```swift
///        .assert<#ElementName#>IsEnabled(expected: false)
///     ```
func assert<#ElementName#>IsEnabled(expected result: Bool = true) -> Self {
    runActivity(element: "<#element description#>", state: .enabled, expected: result) {
        <#elementName#>.assert(state: .enabled, expected: result)
        return self
    }
}
"""
        )
    }
    
    private static func assertElementIsSelected() -> Snippet {
        return Snippet(
            title: "Assert Selected func",
            description: "Asserts if the element is selected. Returns self for chaining.",
            content:
"""
/// Asserts if the `<#elementName#>` is selected.
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: Self. Returns self for the chaining purpose
/// - _Examples:_
///   - To verify the element is selected:
///     ```swift
///        .assert<#ElementName#>IsSelected()
///     ```
///   - To verify the element is not selected:
///     ```swift
///        .assert<#ElementName#>IsSelected(expected: false)
///     ```
func assert<#ElementName#>IsSelected(expected result: Bool = true) -> Self {
    runActivity(element: "<#element description#>", state: .selected, expected: result) {
        <#elementName#>.assert(state: .selected, expected: result)
        return self
    }
}
"""
        )
    }
    
    private static func enterText() -> Snippet {
        return Snippet(
            title: "Enter Text func",
            description: "Enters text in the text field.",
            content:
"""
/// Enter the `<#someText (for ex. username, password, etc)#>` into the `<#textFieldName#>`.
/// - parameter <#someText#>: The `<#someText#>` to enter into the `<#textFieldName#>`.
/// - returns: Self. Returns self for the chaining purpose
@discardableResult
func enter(<#someText#>: String) -> Self {
    runActivity(.step, "Enter <#someText#> into the <#textFieldName#>") {
        <#textFieldName#>.tap()
        <#textFieldName#>.typeText(<#someText#>)
        return self
    }
}
"""
        )
    }
    
    private static func screenTemplate() -> Snippet {
        return Snippet(
            title: "Screen Template",
            description: "Screen template for screen transition chaining.",
            content:
"""
import XCTest

final class <#ClassName#>: BaseScreen {
    // MARK: UI elements declaration
    private lazy var <#name#> = <#value#>
    
    // MARK: Screen Initializer
    required init() {
        super.init()
        visible()
    }
    
    // MARK: Visibility
    /// Verifies the screen state by checking that the element unique to this particular screen exists.
    private func visible() {
        runActivity(.screen, "Verifying if the screen is present") {
            XCTAssertTrue(<#elementName#>.wait(for: .navigation), "\\(Icons.error.rawValue) \\(screenName) is not present")
        }
    }
    
    // MARK: Actions
    /// Taps the `<#elementName#>`
    /// - returns: Self. Returns self for the chaining purpose
    @discardableResult
    func tap<#ElementName#>() -> Self {
        runActivity(.step, "Tap the `<#elementName#>`") {
            <#elementName#>.tap()
            return self
        }
    }
    
    // MARK: Assertions
    /// Asserts if the `<#elementName#>` exists.
    /// - parameter expected: `Bool`. The expected result, which is `true` by default.
    /// - returns: Self. Returns self for the chaining purpose
    /// - _Examples:_
    ///   - To verify the element exists:
    ///     ```swift
    ///        .assert<#ElementName#>Exists()
    ///     ```
    ///   - To verify the element doesn't exist:
    ///     ```swift
    ///        .assert<#ElementName#>Exists(expected: false)
    ///     ```
    func assert<#ElementName#>Exists(expected result: Bool = true) -> Self {
        runActivity(element: "<#element description#>", state: .exists, expected: result) {
            <#elementName#>.assert(state: .exists, expected: result)
            return self
        }
    }
}

"""
        )
    }

    private static func protocolTemplate() -> Snippet {
        return Snippet(
            title: "SelfChainingExample",
            description: "Example for self-chaining pattern.",
            content:
"""
import Foundation
import XCTest

protocol <#ProtocolName#>: ScreenActivitiesProtocol {
    var screenName: String { get }
    func tap<#ElementName#>(<#argName#>: <#EnumName#>) -> Self
    func assert<#ElementName#>Exists(_ <#argName#>: <#EnumName#>, expected result: Bool) -> Self
}

extension <#ProtocolName#> where Self: BaseScreen {
    var screenName: String {
        String(describing: type(of: self))
    }
    
    /// Tap the <#elementName#>
    /// - parameter <#argName#>: `<#EnumName#>`. The enum to select the <#elementName#> from
    /// - parameter goTo: The name of the screen that is expected after tapping the element.
    /// - returns: Self. Returns self for the chaining purpose
    @discardableResult
    func tap<#ElementName#>(<#argName#>: <#EnumName#>) -> Self {
        runActivity(.step, "Tap `\\(<#argName#>.rawValue)` tab") {
            BaseScreen.app.<#elementType#>[<#argName#>.rawValue].tap()
            return self
        }
    }
    
    /// Asserts if the <#elementName#> exists.
    /// - parameter <#argName#>: `<#EnumName#>`. The enum to select the tab from
    /// - parameter expected: `Bool`. The expected result, which is `true` by default.
    /// - returns: Self. Returns self for the chaining purpose
    /// - _Examples:_
    ///     ```swift
    ///         .assert<#elementName#>Exists(.<#argName#>)
    ///     ```
    ///   - To verify the element doesn't exist:
    ///     ```swift
    ///         .assert<#elementName#>Exists(.<#argName#>, expected: false)
    ///     ```
    @discardableResult
    func assert<#elementName#>Exists(_ <#argName#>: <#EnumName#>, expected result: Bool = true) -> Self {
        let <#elementName#> = BaseScreen.app.<#elementType#>[<#argName#>.rawValue]
        runActivity(element: "<#element description#>", state: .exists, expected: result) {
            <#elementName#>.assert(state: .exists, expected: result)
        }
        return self
    }
}
"""
        )
    }

    private static func assertElementState() -> Snippet {
        return Snippet(
            title: "Assert Element State func",
            description: "Asserts the element state. Returns self for chaining.",
            content:
"""
/// Asserts the <#elementName#>  state.
/// - parameter state: `ElementState`. An enum to choose the element state to assert.
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: Self. Returns self for the chaining purpose
/// - _Examples:_
///   - To verify the element exists:
///     ```swift
///        .assert<#elementName#>(state: ElementState)
///     ```
///   - To verify the element doesn't exist:
///     ```swift
///        .assert<#elementName#>(state: ElementState, expected: false))
///     ```
@discardableResult
func assert<#elementName#>(state: ElementState, expected result: Bool = true) -> Self {
    runActivity(element: "<#element description#>", state: state, expected: result) {
        <#elementName#>.assert(state: state, result: result)
        return self
    }
}
"""
        )
    }
    
    private static func documentation() -> Snippet {
        return Snippet(
            title: "Documentation",
            description: "Documentation template",
            content:
"""
/// Summary text for documentation
/// - parameter <#parameterName#>: <#Description#>
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
}
