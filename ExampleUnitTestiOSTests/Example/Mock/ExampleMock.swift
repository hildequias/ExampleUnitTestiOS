//
//  ExampleMock.swift
//  ExampleUnitTestiOSTests
//
//  Created by Hildequias Junior on 06/07/21.
//

import Foundation

enum KeyDataMock: String {
    case empty = ""
    case invalid = "MY|KEY"
    case invalidNoSlash = "438947238942347237428947289472374982734897289347982738949823789472893749827894789274897289347298748972893748923798478923748972389478927489278394789274897289347892374892738992340989284092804829038490284223012345"
    case valid = "4389472389423472374289472894723749827348972893479827389498237894728937498278947892748972893472987489728937489237984789237489723894789274892783947892748972893478923748927389923409892840928048290384902842230|12345"
}

enum DataEncrytedMock: String {
    case empty = ""
    case valid = "sdokdsaopdaopskdokasopdkopahuishduiahudisha9890dd9s8d89asu89dasdh89ashd89has89dh89ashd89sah89dh89sahd89a8s9d89asu89dy89asyd89asy89"
}

enum CardNumberMock: String {
    case cardNumberEmpyt = ""
    case cardNumberInvalidMinDigits = "1234"
    case cardNumberInvalidMaxDigits = "1234 1234 4567 3456 1234 12"
    case cardNumberValid = "1234 2849 3950 2934"
}

enum ValidThruMock: String {
    case validThruEmpty = ""
    case validThruInvalid = "13/00"
    case validThruValid = "05/29"
}

enum CvvMock: String {
    case cvvEmpty = ""
    case cvvInvalidMinDigits = "11"
    case cvvInvalidMaxnDigits = "12345"
    case cvv3Valid = "123"
    case cvv4Valid = "1234"
}

class ExampleMock {
    
    let cardNumberInvalidList = [ CardNumberMock.cardNumberEmpyt.rawValue,
                                  CardNumberMock.cardNumberInvalidMinDigits.rawValue,
                                  CardNumberMock.cardNumberInvalidMaxDigits.rawValue ]
    
    let validThruInvalidList = [ ValidThruMock.validThruEmpty.rawValue,
                                 ValidThruMock.validThruInvalid.rawValue ]
    
    let cvvInvalidList = [  CvvMock.cvvEmpty.rawValue,
                                CvvMock.cvvInvalidMinDigits.rawValue,
                                CvvMock.cvvInvalidMaxnDigits.rawValue ]
    
    let cvvValidList = [ CvvMock.cvv3Valid.rawValue,
                            CvvMock.cvv4Valid.rawValue ]
    
    let keyInvalidList = [ KeyDataMock.empty.rawValue,
                                KeyDataMock.invalid.rawValue,
                                KeyDataMock.invalidNoSlash.rawValue]
}
