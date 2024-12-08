//
//  ScreenTransitionChainingSnippets.swift
//  XCUISnippetDeployer
//
//  Created by Natalia Popova on 12/7/24.
//

import Foundation

class ScreenTransitionChainingSnippets {
    static func getAll() -> [Snippet] {
        return [
            tapElement(),
            tapElementAtIndex(),
            tapElementAtIndexGeneric(),
            tapElementGeneric(),
            assertExists(),
            assertExistsAtIndex(),
            assertIsEnabled(),
            assertElementIsSelected(),
            elementNameExistsXCT(),
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
            description: "Tap element and return next screen.",
            content:
"""
/// Taps the `<#elementName#>`
/// - returns: An instance of `<#ScreenName#>` representing the next screen after tapping the element.
@discardableResult
func tap<#ElementName#>() -> <#ScreenName#> {
    runActivity(.step, "Tap the `<#elementName#>`") {
        <#elementName#>.tap()
        return <#ScreenName#>()
    }
}
"""
        )
    }
    
    private static func tapElementAtIndex() -> Snippet {
        return Snippet(
            title: "Tap index func",
            description: "Tap element at index and return next screen.",
            content:
"""
/// Taps the `<#elementQuery#>`
/// - parameter index: The index of the element to tap. Default is 0.
/// - returns: An instance of `<#ScreenName#>` representing the next screen after tapping the element.
@discardableResult
func tap<#ElementQuery#>(index: Int = 0) -> <#ScreenName#> {
    runActivity(.step, "Tap the `<#elementQuery#>` at index `\\(index)`") {
        <#elementQuery#>.element(boundBy: index).tap()
        return <#ScreenName#>()
    }
}
"""
        )
    }
    
    private static func tapElementAtIndexGeneric() -> Snippet {
        return Snippet(
            title: "Tap index func Generic",
            description: "Tap element at index and returns a generic screen.",
            content:
"""
/// Taps the `<#elementQuery#>`
/// - parameter index: The index of the element to tap. Default is 0.
/// - returns: An instance of the generic screen depending on the flow, after tapping the element.
@discardableResult
func tap<#ElementQuery#><T>(index: Int = 0, screen: T.Type) -> T where T: BaseScreen {
    runActivity(.step, "Tap the `<#elementQuery#>` at index `\\(index)`") {
        <#elementQuery#>.element(boundBy: index).tap()
        return T()
    }
}
"""
        )
    }
    
    private static func tapElementGeneric() -> Snippet {
        return Snippet(
            title: "Tap func Generic",
            description: "Taps element and returns a generic screen.",
            content:
"""
/// Taps the `<#elementName#>`
/// - parameter screen: The screen to navigate to after tapping the button.
/// - returns: An instance of the generic screen depending on the flow, after tapping the element.
@discardableResult
func tap<#ElementName#><T>(screen: T.Type) -> T where T: BaseScreen {
    runActivity(.step, "Tap the `<#elementName#>`") {
        <#elementName#>.tap()
        return T()
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
/// Asserts if the `<#elementName#>` exists.
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: Self. Returns self for the chaining purpose
/// - _Examples:_
///   - To verify the element exists:
///     ```swift
///     <#screenName#>.assert<#ElementName#>Exists()
///     ```
///   - To verify the element doesn't exist:
///     ```swift
///    <#screenName#>.assert<#ElementName#>Exists(expected: false)
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
/// Asserts if the `<#ElementQuery#>` at index exists.
/// - parameter index: The index of the element to verify. Default is 0.
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: Self. Returns self for the chaining purpose
/// - _Examples:_
///   - To verify the element at index 3 exists:
///     ```swift
///     <#screenName#>.assert<#ElementQuery#>Exists(index: 3)
///     ```
///   - To verify the element at index 5 doesn't exist:
///     ```swift
///    <#screenName#>.assert<#ElementQuery#>Exists(index: 5, expected: false)
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
///     <#screenName#>.assert<#ElementName#>IsEnabled()
///     ```
///   - To verify the element is not enabled:
///     ```swift
///    <#screenName#>.assert<#ElementName#>IsEnabled(expected: false)
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
///     <#screenName#>.assert<#ElementName#>IsSelected()
///     ```
///   - To verify the element is not selected:
///     ```swift
///    <#screenName#>.assert<#ElementName#>IsSelected(expected: false)
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
    
    private static func elementNameExistsXCT() -> Snippet {
        return Snippet(
            title: "XCT verify Exists func",
            description: "Element exists to use with XCTAssert. Returns Bool.",
            content:
"""
/// Asserts if the `<#elementName#>` exists.
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: `Bool`. Returns `true` if the button's state matches the expected result, otherwise `false`.
/// - warning: Use with `XCTAssertTrue`. If you want to assert that the element doesn't exist, set the expected result to `false`. This helps the test to run faster.
/// - _Examples:_
///   - To verify the element exists:
///     ```swift
///     XCTAssertTrue(<#screenName#>.<#elementName#>Exists()
///     ```
///   - To verify the element doesn't exist:
///     ```swift
///     XCTAssertTrue(<#screenName#>.<#elementName#>Exists(expected: false))
///     ```
@discardableResult
func <#elementName#>Exists(expected result: Bool = true) -> Bool {
    return runActivity(element: "<#Element description#>", state: .exists, expected: result) {
        <#elementName#>.wait(state: .exists, result: result)
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
/// - returns: An instance of the same screen.
@discardableResult
func enter(<#someText#>: String) -> Self {
    runActivity(.step, "Enter <#someText#> into the <#textFieldName#>") {
        <#textFieldName#>.tap()
        <#textFieldName#>.typeText(<#someText#>)
        return Self()
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
    /// - returns: An instance of `<#ScreenName#>` representing the next screen after tapping the element.
    @discardableResult
    func tap<#ElementName#>() -> <#ScreenName#> {
        runActivity(.step, "Tap the `<#elementName#>`") {
            <#elementName#>.tap()
            return <#ScreenName#>()
        }
    }
    
    // MARK: Assertions
    /// Asserts if the `<#elementName#>` exists.
    /// - parameter expected: `Bool`. The expected result, which is `true` by default.
    /// - returns: Self. Returns self for the chaining purpose
    /// - _Examples:_
    ///   - To verify the element exists:
    ///     ```swift
    ///     <#screenName#>.assert<#ElementName#>Exists()
    ///     ```
    ///   - To verify the element doesn't exist:
    ///     ```swift
    ///    <#screenName#>.assert<#ElementName#>Exists(expected: false)
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
            title: "Protocol Template",
            description: "Protocol template with enum argument (optional - remove if not needed) for screen transition chaining.",
            content:
"""
protocol <#ProtocolName#>: ScreenActivitiesProtocol {
    var screenName: String { get }
    func tap<#ElementName#><T>(<#argName#>: <#EnumName#>, goTo screen: T.Type) -> T where T: BaseScreen
    func assert<#elementName#>Exists(_ <#argName#>: <#EnumName#>, expected result: Bool) -> Self
}

extension <#ProtocolName#> {
    var screenName: String {
        String(describing: type(of: self))
    }
    
    /// Tap the <#elementName#>
    /// - parameter <#argName#>: `<#EnumName#>`. The enum to select the <#elementName#> from
    /// - parameter goTo: The name of the screen that is expected after tapping the element.
    /// - returns: An instance of the screen indicated by the `goTo` parameter, representing either the next screen depending on the flow.
    @discardableResult
    func tap<#ElementName#><T>(<#argName#>: <#EnumName#>, goTo screen: T.Type) -> T where T: BaseScreen {
        runActivity(.step, "Tap `\\(<#argName#>.rawValue)`") {
            BaseScreen.app.<#elementType#>[<#argName#>.rawValue].tap()
            return T()
        }
    }
    
    /// Asserts if the <#elementName#> exists.
    /// - parameter <#argName#>: `<#EnumName#>`. The enum to select the tab from
    /// - parameter expected: `Bool`. The expected result, which is `true` by default.
    /// - returns: Self. Returns self for the chaining purpose
    /// - _Examples:_
    ///   - To verify the element exists:
    ///     ```swift
    ///     sceenName.assert<#elementName#>Exists(.<#argName#>)
    ///     ```
    ///   - To verify the element doesn't exist:
    ///     ```swift
    ///     screenName.assert<#elementName#>Exists(.<#argName#>, expected: false)
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
///     <#screenName#>.assert<#elementName#>(state: ElementState)
///     ```
///   - To verify the element doesn't exist:
///     ```swift
///     <#screenName#>.assert<#elementName#>(state: ElementState, expected: false))
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
    
