//
//  Cell.swift
//  NumberFormatter
//
//  Created by kingkong999yhirose on 2015/12/12.
//  Copyright © 2015年 kingkong999yhirose. All rights reserved.
//

import UIKit

class Model {
    var value: Double = 0.0
    var currencyCode = NSLocale.currentLocale().displayNameForKey(NSLocaleCurrencySymbol, value: NSLocaleCurrencyCode)
}

class cellViewModel {
    var model: Model = Model()
    var value: String {
        get {
            guard self.model.value > 0.0 else {
                return ""
            }
            if self.model.value * 100 % 100 == 0 { // TODO: int to stirng
                return Int(self.model.value).description
            }
            return self.model.value.description
        }
    }
    
    var formatValue: String? {
        get {
            let ft = self.formatter()
            return ft.stringFromNumber(self.model.value)
        }
    }
    var currencyCode: String {
        get {
            return model.currencyCode ?? ""
        }
    }
    
    private func formatter() -> NSNumberFormatter {
        let ft = NSNumberFormatter()
        ft.currencySymbol = ""
        ft.currencyCode = self.currencyCode
        ft.numberStyle = .CurrencyStyle
        ft.allowsFloats = true
        ft.decimalSeparator = ","
        ft.maximumFractionDigits = 2
        return ft
    }
    
    func updateValue(text: String) {
        let ft = self.formatter()
        let t = text.removeString(",")
        if let value = ft.numberFromString(t)?.doubleValue {
            self.model.value = value
        }
    }
}

class Cell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var viewModel: cellViewModel = cellViewModel() {
        didSet {
            update()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textField.placeholder = "non text"
        self.textField.addTarget(self, action: "didBeginEdit:", forControlEvents: .EditingDidBegin)
        self.textField.addTarget(self, action: "didEndEdit:", forControlEvents: .EditingDidEnd)
        self.textField.keyboardType = .NumberPad
    }
    
    func didBeginEdit(textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        guard text.isEmpty else {
            return
        }
        textField.text = self.viewModel.value
    }
    
    func didEndEdit(textField: UITextField) {
        guard let text = textField.text where !text.isEmpty else {
            textField.text = ""
            return
        }
        self.viewModel.updateValue(text)
        self.textField.text = self.viewModel.formatValue
    }
    
    private func update() {
        self.label.text = self.viewModel.currencyCode
        if self.textField.isFirstResponder() {
            self.didBeginEdit(self.textField)
        } else {
            self.didEndEdit(self.textField)
        }
    }
    
}
