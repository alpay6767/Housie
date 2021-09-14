//
//  Event.swift
//  Housie
//
//  Created by Alpay Kücük on 05.08.21.
//

import Foundation
import UIKit

class Event: Codable {
    
    var payedloan: Int
    var spendtime: Int
    var date: String
    
    init(date: String, payedloan: Int, spendtime: Int) {
        self.date = date
        self.payedloan = payedloan
        self.spendtime = spendtime
    }
    
}
