//
//  Cryptor.swift
//  ExampleUnitTestiOS
//
//  Created by Hildequias Junior on 07/07/21.
//

import Foundation
import RNCryptor

protocol CryptorDelegate: AnyObject {
    func encrypt(data: Data, withPassword password: String) -> String
}

class Cryptor: CryptorDelegate {
    func encrypt(data: Data, withPassword password: String) -> String {
        return RNCryptor.encrypt(data: data, withPassword: password).base64EncodedString()
    }
}
