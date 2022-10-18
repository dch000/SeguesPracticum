//
//  SyntaxSugar.swift
//  SeguesDemo
//
//  Created by Dmitry Isaev on 18/10/2022.
//

import UIKit
import Combine

extension UITextField {
	var intValue: Int {
		Int(text ?? "0") ?? 0
	}

	var intValuePublisher: AnyPublisher<Int, Never> {
		NotificationCenter.default
			.publisher(for: UITextField.textDidChangeNotification, object: self)
			.map { Int(($0.object as? UITextField)?.text ?? "") ?? 0 }
			.eraseToAnyPublisher()
	}
}
