//
//  ErrorModel.swift
//  ExampleUnitTestiOS
//
//  Created by Hildequias Junior on 06/07/21.
//

import Foundation

enum ErrorModel: Error {
    case generic
    case keyInvalid
    case encrytedFail
    case dataInvalid
}

extension ErrorModel: Equatable {
    public var code: Int {
        switch self {
        case .generic:
            return -1000
            
        case .keyInvalid:
            return -2000
            
        case .encrytedFail:
            return -4000
        
        case .dataInvalid:
            return -5000
        }
    }
    
    public var title: String {
        switch self {
        case .generic:
            return "Error unknow"
            
        case .keyInvalid:
            return "Invalid Key"
            
        case .encrytedFail:
            return "Encrypt fail"
        
        case .dataInvalid:
            return "Invalid Data"
        }
    }
    
    public var message: String {
        switch self {
        case .generic:
            return "An unknown error has occurred"
            
        case .keyInvalid:
            return "Your key to encrypt the data is invalid"
            
        case .encrytedFail:
            return "Data encryption failed"
        
        case .dataInvalid:
            return "Invalid card data"
        }
    }
}
