//
//  CalculatorViewModel.swift
//  Calculator-S
//
//  Created by Hemant on 29/06/25.
//

import Foundation

final class CalculatorViewModel {

    private let calculator = StringCalculator()

    @Published private(set) var resultText: String = ""
    @Published private(set) var isError: Bool = false

    func calculate(from input: String) {
        do {
            let result = try calculator.throwingAdd(input)
            resultText = "Result: \(result)"
            isError = false
        } catch {
            resultText = error.localizedDescription
            isError = true
        }
    }
}
