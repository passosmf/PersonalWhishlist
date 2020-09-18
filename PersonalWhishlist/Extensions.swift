//
//  UITextFieldExtensions.swift
//  BuyList
//
//  Created by Marcio P Ferreira on 17/09/20.
//  Copyright © 2020 Passos. All rights reserved.
//
import Foundation

import UIKit

extension String {
    func truncate(to length: Int) -> String  {
        if length > count { return self }
        let endPosition = self.index(self.startIndex, offsetBy: length)
        let trimmed = self[..<endPosition]
        return "\(trimmed)..."
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldName {
            textFieldQuantity.becomeFirstResponder()
        } else {
            textFieldQuantity.resignFirstResponder()
        }
        return true
    }
}
