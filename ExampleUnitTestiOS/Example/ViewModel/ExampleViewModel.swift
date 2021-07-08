//
//  ExampleViewModel.swift
//  ExampleUnitTestiOS
//
//  Created by Hildequias Junior on 06/07/21.
//

import Foundation

protocol ExampleViewModelDelegate: AnyObject {
    func show(viewModel: ExampleViewModel, with error: ErrorModel)
    func show(viewModel: ExampleViewModel, with data: String)
}

class ExampleViewModel {
    
    //MARK: Properties
    var cardDataModel: CardDataModel
    private var repository: Repository
    private var rules: ExampleViewModelRules
    private var cryptor: CryptorDelegate
        
    //MARK: Delegate propeties
    weak var delegate: ExampleViewModelDelegate?
    
    //MARK: init
    init(_ cryptor: CryptorDelegate = Cryptor()) {
        repository = Repository()
        cardDataModel = CardDataModel()
        rules = ExampleViewModelRules()
        self.cryptor = cryptor
        rules.delegate = self
    }
    
    //MARK: Public Methods
    func beginEncryption() {
        rules.checkCardData(model: cardDataModel)
    }
}

//MARK: ExampleViewModelRules Delegate
extension ExampleViewModel: ExampleViewModelRulesDelegate {
    
    internal func getEncryptionKey(_ rules: ExampleViewModelRules) {
        rules.checkKey(key: repository.getKey())
    }
    
    internal func encryptData(_ rules: ExampleViewModelRules, key: String) {
        DispatchQueue.global(qos: .utility).async {
            let data = String(format: "%@|%@|%@",
                              self.cardDataModel.cardNumber ?? "",
                              self.cardDataModel.cvv ?? "",
                              self.cardDataModel.validThru ?? "").data(using: .utf8) ?? Data()
            let result = self.cryptor.encrypt(data: data, withPassword: key)
            DispatchQueue.main.async {
                rules.checkEncryptedData(data: result)
            }
        }
    }
    
    internal func encryptError(_ rules: ExampleViewModelRules, error: ErrorModel) {
        delegate?.show(viewModel: self, with: error)
    }
    
    internal func encryptedData(_ rules: ExampleViewModelRules, data: String) {
        delegate?.show(viewModel: self, with: data)
    }
}
