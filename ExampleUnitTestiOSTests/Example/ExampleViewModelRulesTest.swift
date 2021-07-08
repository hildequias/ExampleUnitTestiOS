//
//  ExampleViewModelRulesTest.swift
//  ExampleUnitTestiOSTests
//
//  Created by Hildequias Junior on 06/07/21.
//

import XCTest
@testable import ExampleUnitTestiOS

class ExampleViewModelRulesTest: XCTestCase {

    var rules: ExampleViewModelRules?
    var repository: Repository?
    var error: ErrorModel?
    var key: String?
    var dataEncryted: String?
    var getEncryptionKey: Bool = false
    
    override func setUp() {
        rules = ExampleViewModelRules()
        repository = Repository()
        rules?.delegate = self
    }
    
    override func tearDown() {
        rules = nil
        repository = nil
        clearData()
    }
    
    func clearData() {
        error = nil
        key = nil
        dataEncryted = nil
        getEncryptionKey = false
    }

    func testCheckCardDataWithCardNumberInvalid() {
        var model = CardDataModel()
        let cardNumberList = ExampleMock().cardNumberInvalidList
        
        for cardNumber in cardNumberList {
            clearData()
            model.cardNumber = cardNumber
            rules?.checkCardData(model: model)
            XCTAssertEqual(error, .dataInvalid)
            XCTAssertNil(dataEncryted)
            XCTAssertFalse(getEncryptionKey)
        }
    }
    
    func testCheckCardDataWithValidThruInvalid() {
        var model = CardDataModel()
        let validThruList = ExampleMock().validThruInvalidList
        
        for validThru in validThruList {
            clearData()
            model.validThru = validThru
            rules?.checkCardData(model: model)
            XCTAssertEqual(error, .dataInvalid)
            XCTAssertNil(dataEncryted)
            XCTAssertFalse(getEncryptionKey)
        }
    }
    
    func testCheckCardDataWithCvvInvalid() {
        var model = CardDataModel()
        let cvvInvalidList = ExampleMock().cvvInvalidList
        
        for cvv in cvvInvalidList {
            clearData()
            model.cvv = cvv
            rules?.checkCardData(model: model)
            XCTAssertEqual(error, .dataInvalid)
            XCTAssertNil(dataEncryted)
            XCTAssertFalse(getEncryptionKey)
        }
    }
    
    func testCheckCardDataValid() {
        var model = CardDataModel()
        model.cardNumber = CardNumberMock.cardNumberValid.rawValue
        model.validThru = ValidThruMock.validThruValid.rawValue
        model.cvv = CvvMock.cvv3Valid.rawValue
        rules?.checkCardData(model: model)
        XCTAssertNil(error)
        XCTAssertTrue(getEncryptionKey)
    }
    
    func testCheckKeyInvalid() {
        let keyInvalidList = ExampleMock().keyInvalidList
        for keyInvalid in keyInvalidList {
            rules?.checkKey(key: keyInvalid)
            XCTAssertEqual(error, .keyInvalid)
            XCTAssertNil(key)
        }
    }
    
    func testCheckKeyIsValid() {
        let validKey = KeyDataMock.valid.rawValue
        rules?.checkKey(key: validKey)
        XCTAssertNil(error)
        XCTAssertNotNil(key)
    }
    
    func testCheckEncryptedDataEmpty() {
        let data = DataEncrytedMock.empty.rawValue
        rules?.checkEncryptedData(data: data)
        XCTAssertEqual(error, .encrytedFail)
        XCTAssertNil(dataEncryted)
    }
    
    func testCheckEncryptedDataIsValid() {
        let data = DataEncrytedMock.valid.rawValue
        rules?.checkEncryptedData(data: data)
        XCTAssertNil(error)
        XCTAssertNotNil(dataEncryted)
    }
}

extension ExampleViewModelRulesTest: ExampleViewModelRulesDelegate {
    func encryptedData(_ rules: ExampleViewModelRules, data: String) {
        self.dataEncryted = data
    }
    
    func getEncryptionKey(_ rules: ExampleViewModelRules) {
        self.getEncryptionKey = true
    }
    
    func encryptError(_ rules: ExampleViewModelRules, error: ErrorModel) {
        self.error = error
    }
    
    func encryptData(_ rules: ExampleViewModelRules, key: String) {
        self.key = key
    }
}
