//
//  ExampleViewModelRules.swift
//  ExampleUnitTestiOS
//
//  Created by Hildequias Junior on 06/07/21.
//

import Foundation

protocol ExampleViewModelRulesDelegate: AnyObject {
    func getEncryptionKey(_ rules: ExampleViewModelRules)
    func encryptError(_ rules: ExampleViewModelRules, error: ErrorModel)
    func encryptData(_ rules: ExampleViewModelRules, key: String)
    func encryptedData(_ rules: ExampleViewModelRules, data: String)
}

class ExampleViewModelRules: NSObject {
    
    //MARK: Properties
    weak var delegate: ExampleViewModelRulesDelegate?
    private let minNumberCharacters = 100
    private let maximumDigitNumber = 20
    private let minimumDigitNumber = 13
    private let maximumDigitCvv = 4
    private let minimumDigitCvv = 3
    private let monthYearFormat = "MM/yy"
    
    //MARK: Public methods
    func checkCardData(model: CardDataModel) {
        if isInvalidCardNumber(cardNumber: model.cardNumber ?? "")
            || isInvalidCvv(cvv: model.cvv ?? "")
            || isInvalidDate(date: model.validThru ?? "") {
            
            delegate?.encryptError(self, error: .dataInvalid)
            return
        }
        delegate?.getEncryptionKey(self)
    }

    func checkKey(key: String) {
        if key.isEmpty
            || !key.contains("|")
            || key.count < minNumberCharacters {
            delegate?.encryptError(self, error: .keyInvalid)
            return
        }
        
        delegate?.encryptData(self, key: key)
    }
    
    func checkEncryptedData(data: String) {
        if data.isEmpty {
            delegate?.encryptError(self, error: .encrytedFail)
            return
        }
        delegate?.encryptedData(self, data: data)
    }
    
    //MARK: Private methods
    private func isInvalidCardNumber(cardNumber: String) -> Bool {
        if cardNumber.isEmpty
            || cardNumber.count < minimumDigitNumber
            || cardNumber.count > maximumDigitNumber {
            return true
        }
        return false
    }
    
    private func isInvalidDate(date: String) -> Bool {
        
        if date.replacingOccurrences(of: " ", with: "").count != 5 {
            return true
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = monthYearFormat
        guard dateFormatter.date(from: date) != nil else { return true }
        return false
    }
    
    private func isInvalidCvv(cvv: String) -> Bool {
        if cvv.isEmpty
            || cvv.count < minimumDigitCvv
            || cvv.count > maximumDigitCvv {
            return true
        }
        return false
    }
}
