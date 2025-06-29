//
//  StringCalulator.swift
//  Calculator-S
//
//  Created by Hemant on 29/06/25.
//

import Foundation

enum StringCalculatorError: Error, LocalizedError {
    case negativesNotAllowed([Int])

    var errorDescription: String? {
        switch self {
        case .negativesNotAllowed(let numbers):
            return "Negative numbers not allowed: \(numbers.map(String.init).joined(separator: ", "))"
        }
    }
}

class StringCalculator {
    func throwingAdd(_ input: String) throws -> Int {
        guard !input.isEmpty else { return 0 }

        var delimiterSet: CharacterSet = [",", "\n"]
        var numbersString = input

        if input.hasPrefix("//") {
            let components = input.components(separatedBy: "\n")
            if let delimiterLine = components.first,
               let delimiter = delimiterLine.dropFirst(2).first {
                delimiterSet = CharacterSet(charactersIn: String(delimiter))
                numbersString = components.dropFirst().joined(separator: "\n")
            }
        }

        let splitNumbers = numbersString.components(separatedBy: delimiterSet)
        let intNumbers = splitNumbers.compactMap { Int($0) }

        let negatives = intNumbers.filter { $0 < 0 }
        if !negatives.isEmpty {
            throw StringCalculatorError.negativesNotAllowed(negatives)
        }

        return intNumbers.reduce(0, +)
    }
}
