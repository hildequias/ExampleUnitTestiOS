//
//  ExampleViewModelTest.swift
//  ExampleUnitTestiOSTests
//
//  Created by Hildequias Junior on 06/07/21.
//

import XCTest
@testable import ExampleUnitTestiOS

class ExampleViewModelTest: XCTestCase {

    enum DelegateHit {
        case showWithError
        case showWithData
    }
    
    var onDidDelegateHit: ((DelegateHit) -> Void)?
    var viewModel: ExampleViewModel!
    var repository: Repository?
    var error: ErrorModel?
    var data: String?
    
    override func setUp() {
        repository = Repository()
        viewModel = ExampleViewModel()
        viewModel.delegate = self
    }
    
    override func tearDown() {
        clearData()
    }
    
    func clearData() {
        error = nil
        data = nil
    }

    func testBeginEncryptionWithCardNumberInvalid() {
        let cardNumberInvalidList = ExampleMock().cardNumberInvalidList
        for cardNumber in cardNumberInvalidList {
            viewModel.cardDataModel = CardDataModel(cardNumber: cardNumber,
                                                           validThru: ValidThruMock.validThruValid.rawValue,
                                                           cvv: CvvMock.cvv4Valid.rawValue)
            clearData()
            viewModel.beginEncryption()
            XCTAssertEqual(error, .dataInvalid)
        }
    }
    
    func testBeginEncryptionWithValidThruInvalid() {
        let validThruInvalidList = ExampleMock().validThruInvalidList
        for validThru in validThruInvalidList {
            viewModel.cardDataModel = CardDataModel(cardNumber: CardNumberMock.cardNumberValid.rawValue,
                                                           validThru: validThru,
                                                           cvv: CvvMock.cvv4Valid.rawValue)
            clearData()
            viewModel.beginEncryption()
            XCTAssertEqual(error, .dataInvalid)
        }
    }
    
    func testBeginEncryptionWithCvvInvalid() {
        let cvvInvalidList = ExampleMock().cvvInvalidList
        for cvvInvalid in cvvInvalidList {
            viewModel.cardDataModel = CardDataModel(cardNumber: CardNumberMock.cardNumberValid.rawValue,
                                                           validThru: ValidThruMock.validThruValid.rawValue,
                                                           cvv: cvvInvalid)
            clearData()
            viewModel.beginEncryption()
            XCTAssertEqual(error, .dataInvalid)
        }
    }
    
    func testBeginEncryptionWithCardDataValid() {
        repository?.saveKey(key: KeyDataMock.valid.rawValue)
        let expectation = XCTestExpectation(description: "Waiting for completion")
        onDidDelegateHit = { delegate in
            switch delegate {
            case .showWithData:
                expectation.fulfill()
            default: break
            }
        }
        
        viewModel.cardDataModel = CardDataModel(cardNumber: CardNumberMock.cardNumberValid.rawValue,
                                                       validThru: ValidThruMock.validThruValid.rawValue,
                                                       cvv: CvvMock.cvv3Valid.rawValue)
        viewModel.beginEncryption()
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(data)
    }
    
    func testBeginEncryptionWithKeyInvalid() {
        let keyInvalidList = ExampleMock().keyInvalidList
        for keyInvalid in keyInvalidList {
            repository?.saveKey(key: keyInvalid)
            viewModel.cardDataModel = CardDataModel(cardNumber: CardNumberMock.cardNumberValid.rawValue,
                                                           validThru: ValidThruMock.validThruValid.rawValue,
                                                           cvv: CvvMock.cvv3Valid.rawValue)
            clearData()
            viewModel.beginEncryption()
            XCTAssertEqual(error, .keyInvalid)
        }
    }
    
    func testBeginEncryptionWithEncryptionFail() {
        repository?.saveKey(key: KeyDataMock.valid.rawValue)
        viewModel = ExampleViewModel(CryptorMock())
        viewModel.delegate = self
        viewModel.cardDataModel = CardDataModel(cardNumber: CardNumberMock.cardNumberValid.rawValue,
                                                       validThru: ValidThruMock.validThruValid.rawValue,
                                                       cvv: CvvMock.cvv3Valid.rawValue)
        let expectation = XCTestExpectation(description: "Waiting for completion")
        onDidDelegateHit = { delegate in
            switch delegate {
            case .showWithError:
                expectation.fulfill()
            default: break
            }
        }
        viewModel.beginEncryption()
        wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(error, .encrytedFail)
    }
}

extension ExampleViewModelTest: ExampleViewModelDelegate {    
    func show(viewModel: ExampleViewModel, with error: ErrorModel) {
        self.error = error
        onDidDelegateHit?(.showWithError)
    }
    
    func show(viewModel: ExampleViewModel, with data: String) {
        self.data = data
        onDidDelegateHit?(.showWithData)
    }
}
