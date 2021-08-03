//
//  User.swift
//  Housie
//
//  Created by Alpay Kücük on 03.08.21.
//

import Foundation
import UIKit

class User {
    
    var id: String?
    var coins: Int?
    var listOfHouses = [House]()
    var listOfUnlockedHouses = [String]()
    var costsOfUnlockedHouses = [Int]()
    
    init(id: String, coins: Int) {
        self.id = id
        self.coins = coins
    }
    
    
}
