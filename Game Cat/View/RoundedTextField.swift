//
//  RoundedTextField.swift
//  Game Cat
//
//  Created by Davin Djayadi on 29/10/22.
//

import UIKit

class RoundedTextField: UITextField {
    private let padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.layer.cornerRadius = 10
        self.delegate = self
        self.activateIdleBorder()
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func activatePrimaryBorder() {
        layer.borderColor = UIColor.primaryColor.cgColor
        layer.borderWidth = CGFloat(2.0)
    }
    
    private func activateIdleBorder() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = CGFloat(1.0)
    }
}

extension RoundedTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activatePrimaryBorder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activateIdleBorder()
    }
}
