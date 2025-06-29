//
//  Calculator_STests.swift
//  Calculator-STests
//
//  Created by Hemant on 29/06/25.
//

import XCTest
@testable import Calculator_S

final class StringCalculatorTests: XCTestCase {

    var calculator: StringCalculator!

    override func setUp() {
        super.setUp()
        calculator = StringCalculator()
    }

    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    // MARK: - Basic Input

    func testEmptyStringReturnsZero() {
        XCTAssertEqual(try calculator.throwingAdd(""), 0)
    }

    func testSingleNumberReturnsThatNumber() {
        XCTAssertEqual(try calculator.throwingAdd("5"), 5)
    }

    func testTwoCommaSeparatedNumbersReturnsSum() {
        XCTAssertEqual(try calculator.throwingAdd("1,2"), 3)
    }

    func testMultipleCommaSeparatedNumbers() {
        XCTAssertEqual(try calculator.throwingAdd("1,2,3,4,5"), 15)
    }

    // MARK: - Newline Support

    func testHandlesNewlinesAndCommasTogether() {
        XCTAssertEqual(try calculator.throwingAdd("1\n2,3"), 6)
    }

    // MARK: - Custom Delimiter

    func testSupportsCustomDelimiterSemicolon() {
        XCTAssertEqual(try calculator.throwingAdd("//;\n1;2"), 3)
    }

    func testSupportsCustomDelimiterPipe() {
        XCTAssertEqual(try calculator.throwingAdd("//|\n4|5|6"), 15)
    }

    // MARK: - Negative Numbers

    func testThrowsErrorForNegativeNumber() {
        XCTAssertThrowsError(try calculator.throwingAdd("1,-2,3")) { error in
            let err = error as? StringCalculatorError
            XCTAssertEqual(err?.localizedDescription, "Negative numbers not allowed: -2")
        }
    }

    func testThrowsErrorForMultipleNegatives() {
        XCTAssertThrowsError(try calculator.throwingAdd("-1,2,-3")) { error in
            let err = error as? StringCalculatorError
            XCTAssertEqual(err?.localizedDescription, "Negative numbers not allowed: -1, -3")
        }
    }
}
