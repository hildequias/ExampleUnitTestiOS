//
//  CryptorMock.swift
//  ExampleUnitTestiOSTests
//
//  Created by Hildequias Junior on 07/07/21.
//

import Foundation
@testable import ExampleUnitTestiOS

class CryptorMock: CryptorDelegate {
    var valid: Bool = false
    
    func encrypt(data: Data, withPassword password: String) -> String {
        if valid {
            return DataEncrytedMock.valid.rawValue
        } else {
            return DataEncrytedMock.empty.rawValue
        }
    }
}
