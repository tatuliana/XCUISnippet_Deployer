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
            assertIsSelected(),
            enterText(),
            turnSwitch(),
            enterTextIntoEnumTextField(),
            screenTemplate(),
            protocolWithEnum(),
            protocolTemplate(),
            assertForValue(),
            assertForLabel(),
            assertForPlaceholderValue(),
            testFunc(),
            tapEnumButton()
        ]
    }
    
    private static func tapElement() -> Snippet {
        return Snippet(
            title: "03. Tap func",
            description: "Taps element and returns self for chaining.",
            content:
"""
/// Taps the `<#elementName#>` <#elementType#>.
/// - returns: Self. Returns self for the chaining purpose
@discardableResult
func tap<#ElementName#>() -> Self {
    runActivity(.step, "Tap the `<#elementName#>` <#elementType#>") {
        <#elementName#>.tap()
        return self
    }
}
"""
        )
    }
    
    private static func tapElementAtIndex() -> Snippet {
        return Snippet(
            title: "04. Tap by index func",
            description: "Taps element at index and returns self for chaining.",
            content:
"""
/// Taps the `<#elementQueryName#>` by index.
/// - parameter index: The index of the element to tap. Default is 0.
/// - returns: Self. Returns self for the chaining purpose
@discardableResult
func tap<#elementQueryName#>(index: Int = 0) -> Self {
    runActivity(.step, "Tap the `<#elementQueryName#>` <#elementType#> at index `\\(index)`") {
        <#elementQueryName#>.element(boundBy: index).tap()
        return self
    }
}
"""
        )
    }
    
    private static func assertExists() -> Snippet {
        return Snippet(
            title: "09. Assert Exists func",
            description: "Asserts if the element exists. Returns self for chaining.",
            content:
"""
/// Asserts if the `<#elementName#>` <#elementType#> exists.
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
@discardableResult
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
            title: "10. Assert Exists at index func",
            description: "Asserts if the element at index exists. Returns self for chaining.",
            content:
"""
/// Asserts if the `<#ElementQuery#>` <#elementType#> at index exists.
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
@discardableResult
func assert<#ElementQuery#>Exists(index: Int = 0, expected result: Bool = true) -> Self {
    runActivity(element: "<#element description#> at \\(index)", state: .exists, expected: result) {
        <#elementQuery#>.element(boundBy: index).assert(state: .exists, expected: result)
        return self
    }
}
"""
        )
    }
    
    private static func assertIsEnabled() -> Snippet {
        return Snippet(
            title: "11. Assert Enabled func",
            description: "Asserts if the element is enabled. Returns self for chaining.",
            content:
"""
/// Asserts if the `<#elementName#>` <#elementType#> is enabled.
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
@discardableResult
func assert<#ElementName#>IsEnabled(expected result: Bool = true) -> Self {
    runActivity(element: "<#element description#>", state: .enabled, expected: result) {
        <#elementName#>.assert(state: .enabled, expected: result)
        return self
    }
}
"""
        )
    }
    
    private static func assertIsSelected() -> Snippet {
        return Snippet(
            title: "12. Assert Selected func",
            description: "Asserts if the element is selected. Returns self for chaining.",
            content:
"""
/// Asserts if the `<#elementName#>` <#elementType#> is selected.
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
@discardableResult
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
            title: "06. Enter Text func",
            description: "Enters text in the text field.",
            content:
"""
/// Enter the `<#someText (for ex. username, password, etc)#>` into the `<#textFieldName#>` textField.
/// - parameter <#someText#>: The `<#someText#>` to enter into the `<#textFieldName#>`.
/// - returns: Self. Returns self for the chaining purpose
@discardableResult
func enter(<#someText#>: String) -> Self {
    runActivity(.step, "Enter <#someText#> into the `<#textFieldName#>` textField") {
        <#textFieldName#>.tap()
        <#textFieldName#>.typeText(<#someText#>)
        return self
    }
}
"""
        )
    }
    
    private static func turnSwitch() -> Snippet {
        return Snippet(
            title: "08. Turn switch func",
            description: "Turns switch on/off.",
            content:
"""
/// Turns the `<#switchName#>` switch to the state selected from the `SwitchState` enum
/// - parameter state: `SwitchState`. An enum to select the state from
/// - returns: Self. Returns self for the chaining purpose
@discardableResult
func turn<#switchName#>(_ state: SwitchState) -> Self {
    runActivity(.step, "Turn the `<#switchName#>` switch `\\(state.rawValue)`") {
        <#switchName#>.turnSwitch(state: state)
        return self
    }
}
"""
        )
    }
    
    private static func enterTextIntoEnumTextField() -> Snippet {
        return Snippet(
            title: "07. Enter text into enum func",
            description: "Enters text into the text field which uses enum rawValue as a part of its locator",
            content:
"""
/// Enter the `text` into the text field selected from the `<#enumName#>` enum.
/// - parameter text: String.
/// - parameter textField: `<#enumName#>`. An enum to select the text field from
/// - returns: Self. Returns self for the chaining purpose
@discardableResult
func enter(text: String, into textField: <#enumName#>) -> Self {
    runActivity(.step, "Enter `\\(text)` into the `\\(textField.description)` text field") {
        let field = BaseScreen.app.textFields[textField.rawValue].firstMatch
        field.tap()
        field.typeText(text)
        return self
    }
}
"""
        )
    }
    
    private static func screenTemplate() -> Snippet {
        return Snippet(
            title: "00. Screen Template",
            description: "Screen template for screen transition chaining.",
            content:
"""
import XCTest

final class <#ClassName#>: BaseScreen {
    // MARK: - UI elements declaration
    private lazy var <#name#> = <#value#>
    
    // MARK: - Screen Initializer
    required init() {
        super.init()
        visible()
    }
    
    // MARK: - Visibility
    /// Verifies the screen state by checking that the element unique to this particular screen exists.
    private func visible() {
        runActivity(.screen, "Verifying if the screen is present") {
            XCTAssertTrue(<#elementName#>.wait(for: .loading), "\\(Icons.error.rawValue) \\(screenName) is not present")
        }
    }
    
    // MARK: - Actions
    /// Taps the `<#elementName#>`
    /// - returns: Self. Returns self for the chaining purpose
    @discardableResult
    func tap<#ElementName#>() -> Self {
        runActivity(.step, "Tap the `<#elementName#>`") {
            <#elementName#>.tap()
            return self
        }
    }
    
    // MARK: - Assertions
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
    @discardableResult
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
    
    private static func protocolWithEnum() -> Snippet {
        return Snippet(
            title: "02. Protocol with enum",
            description: "Protocol Template for Self-Chaining pattern.",
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
    
    /// Tap the `<#elementName#>`
    /// - parameter <#argName#>: `<#EnumName#>`. The enum to select the <#elementName#> from
    /// - returns: Self. Returns self for the chaining purpose
    @discardableResult
    func tap<#ElementName#>(<#argName#>: <#EnumName#>) -> Self {
        runActivity(.step, "Tap `\\(<#argName#>.rawValue)` tab") {
            BaseScreen.app.<#elementType#>[<#argName#>.rawValue].tap()
            return self
        }
    }
    
    /// Asserts if the `<#elementName#>` <#elementType#> exists.
    /// - parameter <#argName#>: `<#EnumName#>`. The enum to select the tab from
    /// - parameter expected: `Bool`. The expected result, which is `true` by default.
    /// - returns: Self. Returns self for the chaining purpose
    /// - _Examples:_
    ///   - To verify the element exists:
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
    
    private static func protocolTemplate() -> Snippet {
        return Snippet(
            title: "01. Protocol Template",
            description: "Protocol Template for Self-Chaining pattern.",
            content:
"""
import Foundation
import XCTest

protocol <#ProtocolName#>: ScreenActivitiesProtocol {
    var screenName: String { get }
    func tap<#ElementName#>() -> Self
    func assert<#ElementName#>Exists(expected result: Bool) -> Self
}

extension <#ProtocolName#> where Self: BaseScreen {
    var screenName: String {
        String(describing: type(of: self))
    }
    
    /// Tap the `<#elementName#>`
    /// - returns: Self. Returns self for the chaining purpose
    @discardableResult
    func tap<#ElementName#>() -> Self {
        runActivity(.step, "Tap the `\\(<#elementName#>)` <#elementType#>") {
            BaseScreen.app.<#elementType#>[<#elementName#>].firstMatch.tap()
            return self
        }
    }

    /// Asserts if the `<#elementName#>` <#elementType#> exists.
    /// - parameter expected: `Bool`. The expected result, which is `true` by default.
    /// - returns: Self. Returns self for the chaining purpose
    /// - _Examples:_
    ///   - To verify the element exists:
    ///     ```swift
    ///         .assert<#ElementName#>Exists()
    ///     ```
    ///   - To verify the element doesn't exist:
    ///     ```swift
    ///         .assert<#ElementName#>Exists(expected: false)
    ///     ```
    @discardableResult
    func assert<#elementName#>Exists(expected result: Bool = true) -> Self {
        runActivity(element: "<#element description#>", state: .exists, expected: result) {
            <#elementName#>.assert(state: .exists, expected: result)
        }
        return self
    }
}
"""
        )
    }

    private static func assertForValue() -> Snippet {
        return Snippet(
            title: "13. Assert Value func",
            description: "Asserts if the value is equal to the expected value. Returns self for chaining.",
            content:
"""
/// Asserts if the `<#elementName#>` <#elementType#> value is equal to the expected.
/// - parameter equalTo: String. An expected value of the <#elementName#>
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: Self. Returns self for the chaining purpose
/// - _Examples:_
///   - To verify the element value is equal to expected:
///     ```swift
///        .assert<#ElementName#>Value(equalTo: "expectedResultString")
///     ```
///   - To verify the element value is not equal to expected:
///     ```swift
///        .assert<#ElementName#>Value(equalTo: "expectedResultString", expected: false)
///     ```
@discardableResult
func assert<#ElementName#>Value(equalTo: String, expected result: Bool = true) -> Self {
    runActivity(element: "<#elementName#>", property: .value, equalTo: equalTo, expected: result) {
        <#elementName#>.assert(for: .value, equalTo: equalTo)
        return self
    }
}
"""
        )
    }
    
    private static func assertForLabel() -> Snippet {
        return Snippet(
            title: "14. Assert Label func",
            description: "Asserts if the label is equal to the expected value. Returns self for chaining.",
            content:
"""
/// Asserts if the `<#elementName#>` label is equal to the expected.
/// - parameter equalTo: String. An expected label of the <#elementName#>
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: Self. Returns self for the chaining purpose
/// - _Examples:_
///   - To verify the element label is equal to expected:
///     ```swift
///        .assert<#ElementName#>Label(equalTo: "expectedResultString")
///     ```
///   - To verify the element label is not equal to expected:
///     ```swift
///        .assert<#ElementName#>Label(equalTo: "expectedResultString", expected: false)
///     ```
@discardableResult
func assert<#ElementName#>Label(equalTo: String, expected result: Bool = true) -> Self {
    runActivity(element: "<#elementName#>", property: .label, equalTo: equalTo, expected: result) {
        <#elementName#>.assert(for: .label, equalTo: equalTo)
        return self
    }
}
"""
        )
    }
    
    private static func assertForPlaceholderValue() -> Snippet {
        return Snippet(
            title: "15. Assert placeholderValue func",
            description: "Asserts if the placeholderValue is equal to the expected value. Returns self for chaining.",
            content:
"""
/// Asserts if the `<#elementName#>` <#elementType#> placeholderValue is equal to the expected.
/// - parameter equalTo: String. An expected placeholderValue of the <#elementName#>
/// - parameter expected: `Bool`. The expected result, which is `true` by default.
/// - returns: Self. Returns self for the chaining purpose
/// - _Examples:_
///   - To verify the element placeholderValue is equal to expected:
///     ```swift
///        .assert<#ElementName#>PlaceholderValue(equalTo: "expectedResultString")
///     ```
///   - To verify the element placeholderValue is not equal to expected:
///     ```swift
///        .assert<#ElementName#>PlaceholderValue(equalTo: "expectedResultString", expected: false)
///     ```
@discardableResult
func assert<#ElementName#>PlaceholderValue(equalTo: String, expected result: Bool = true) -> Self {
    runActivity(element: "<#elementName#>", property: .placeholderValue, equalTo: equalTo, expected: result) {
        <#elementName#>.assert(for: .placeholderValue, equalTo: equalTo)
        return self
    }
}
"""
        )
    }
    
    private static func testFunc() -> Snippet {
        return Snippet(
            title: "16. Test func",
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
    
    private static func tapEnumButton() -> Snippet {
        return Snippet(
            title: "05. Tap enum button func",
            description: "Taps button selected from an enum",
            content:
"""
/// Taps a button selected from the `<#enumName#>` enum
/// - parameter button: `<#enumName#>`. An enum to select a button from
/// - returns: Self. Returns self for the chaining purpose
@discardableResult
func tap(_ button: <#enumName#>) -> Self {
    runActivity(.step, "Tap the `\\(button.description)` button") {
        BaseScreen.app.buttons[button.rawValue].tap()
        return self
    }
}
"""
        )
    }
}
