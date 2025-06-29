//
//  ViewController.swift
//  Calculator-S
//
//  Created by Hemant on 29/06/25.
//

import UIKit

final class ViewController: UIViewController {

    private let viewModel = CalculatorViewModel()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let inputTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter numbers like 1,2 or //;\n1;2"
        tf.font = .systemFont(ofSize: 16)
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 8
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        title = "String Calculator"
        setupUI()
        
    }

    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(inputTextField)
        containerView.addSubview(calculateButton)
        containerView.addSubview(resultLabel)

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            inputTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            inputTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            inputTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            inputTextField.heightAnchor.constraint(equalToConstant: 44),

            calculateButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 16),
            calculateButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            calculateButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            calculateButton.heightAnchor.constraint(equalToConstant: 44),

            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            resultLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func calculateTapped() {
        viewModel.calculate(from: inputTextField.text ?? "")
        resultLabel.text = viewModel.resultText
        resultLabel.textColor = viewModel.isError ? .systemRed : .systemGreen
    }
}
