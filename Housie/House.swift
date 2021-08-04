//
//  File.swift
//  Housie
//
//  Created by Alpay Kücük on 03.08.21.
//

import Foundation
import UIKit

class House {
    
    var id: String?
    var name: String?
    var price: Int?
    var remainingPrice: Int?
    var finished = false
    var image: UIImage?
    var noimage: UIImage?
    var unlocked = false
    
    init(id: String, name: String, price: Int, image: UIImage, noimage: UIImage) {
        self.id = id
        self.name = name
        self.price = price
        self.remainingPrice = price
        self.image = image
        self.noimage = noimage
    }
    
}


class ModelData {
    
    var houses = [House]()
    var badges = [Badge]()
    
    init() {
        initHouses()
    }
    
    func initHouses() {
        let h1 = House(id: "1", name: "Mark Puckerbergs Villa", price: 2000000, image: UIImage(named: "h1")!, noimage: UIImage(named: "n1")!)
        let h2 = House(id: "2", name: "Larry Fages House", price: 500000, image: UIImage(named: "h2")!, noimage: UIImage(named: "n2")!)
        let h3 = House(id: "3", name: "Bill Mates House", price: 120000, image: UIImage(named: "h3")!, noimage: UIImage(named: "n3")!)
        let h4 = House(id: "4", name: "Steve Jobs Villa", price: 650000, image: UIImage(named: "h4")!, noimage: UIImage(named: "n4")!)
        let h5 = House(id: "5", name: "Larry Eppisons House", price: 210000, image: UIImage(named: "h5")!, noimage: UIImage(named: "n5")!)
        let h6 = House(id: "6", name: "Jeff Lezoz Villa", price: 5600000, image: UIImage(named: "h6")!, noimage: UIImage(named: "n6")!)
        let h7 = House(id: "7", name: "Sergey Grins House", price: 80000, image: UIImage(named: "h7")!, noimage: UIImage(named: "n7")!)
        let h8 = House(id: "8", name: "Jack Kas House", price: 45000, image: UIImage(named: "h8")!, noimage: UIImage(named: "n8")!)
        let h9 = House(id: "9", name: "Alpay Kücüks House", price: 26000, image: UIImage(named: "h9")!, noimage: UIImage(named: "n9")!)
       
        
        houses.append(h1)
        houses.append(h2)
        houses.append(h3)
        houses.append(h4)
        houses.append(h5)
        houses.append(h6)
        houses.append(h7)
        houses.append(h8)
        houses.append(h9)
        
    }
    
    func mapHousesintoarray() {
        let defaults = UserDefaults.standard
        var array = [Int]()

        for haus in houses {
            array.append(haus.price!)
        }
        
        defaults.set(array, forKey: "costsofhouses")
        
    }
    
}
