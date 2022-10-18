//
//  CalcViewController.swift
//  SeguesDemo
//
//  Created by Dmitry Isaev on 18/10/2022.
//

import UIKit
import Combine

class CalcViewController: UIViewController {
	@IBOutlet weak var firstNumber: UITextField!
	@IBOutlet weak var secondNumber: UITextField!
	@IBOutlet weak var doCalcButton: UIButton!

	private var cancellables = Set<AnyCancellable>()

	override func viewDidLoad() {
		super.viewDidLoad()

		firstNumber.intValuePublisher
			.receive(on: RunLoop.main)
			.combineLatest(secondNumber.intValuePublisher)
			.map { numbers in
				"Сложить \(numbers.0) + \(numbers.1)"
			}
			.sink {
				self.doCalcButton.setTitle($0, for: .normal)
			}
			.store(in: &cancellables)
	}

	@IBAction func doCalc(_ sender: UIControl) {
		let sum = firstNumber.intValue + secondNumber.intValue
		let alert = UIAlertController(title: "Сумма", message: "=\(sum)", preferredStyle: .alert)
		alert.addAction(.init(title: "Окей", style: .default))
		present(alert, animated: true)
	}
}
