//
//  CardDataModel.swift
//  ExampleUnitTestiOS
//
//  Created by Hildequias Junior on 06/07/21.
//

import Foundation

struct CardDataModel {
    var cardNumber: String?
    var validThru: String?
    var cvv: String?
    
    init() {
    }
    
    init(cardNumber: String, validThru: String, cvv: String) {
        self.cardNumber = cardNumber
        self.validThru = validThru
        self.cvv = cvv
    }
}
