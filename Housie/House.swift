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
    var step: Int?
    
    init(id: String, name: String, price: Int, image: UIImage, noimage: UIImage, step: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.remainingPrice = price
        self.image = image
        self.noimage = noimage
        self.step = step
    }
    
}


class ModelData {
    
    var houses = [House]()
    var badges = [Badge]()
    
    init() {
        initHouses()
    }
    
    func initHouses() {
        let h1 = House(id: "1", name: "Mark Puckerbergs Villa", price: 2000000, image: UIImage(named: "h1")!, noimage: UIImage(named: "n1")!, step: 1000)
        let h2 = House(id: "2", name: "Larry Fages House", price: 500000, image: UIImage(named: "h2")!, noimage: UIImage(named: "n2")!, step: 1000)
        let h3 = House(id: "3", name: "Bill Mates House", price: 120000, image: UIImage(named: "h3")!, noimage: UIImage(named: "n3")!, step: 1000)
        let h4 = House(id: "4", name: "Steve Jobs Villa", price: 650000, image: UIImage(named: "h4")!, noimage: UIImage(named: "n4")!, step: 1000)
        let h5 = House(id: "5", name: "Larry Eppisons House", price: 210000, image: UIImage(named: "h5")!, noimage: UIImage(named: "n5")!, step: 1000)
        let h6 = House(id: "6", name: "Jeff Lezoz Villa", price: 5600000, image: UIImage(named: "h6")!, noimage: UIImage(named: "n6")!, step: 1000)
        let h7 = House(id: "7", name: "Sergey Grins House", price: 80000, image: UIImage(named: "h7")!, noimage: UIImage(named: "n7")!, step: 1000)
        let h8 = House(id: "8", name: "Jack Kas House", price: 45000, image: UIImage(named: "h8")!, noimage: UIImage(named: "n8")!, step: 1000)
        let h9 = House(id: "9", name: "Alpay Kücüks House", price: 26000, image: UIImage(named: "h9")!, noimage: UIImage(named: "n9")!, step: 1000)
        
        let i1 = House(id: "10", name: "ZBOX One", price: 450, image: UIImage(named: "i1")!, noimage: UIImage(named: "nt1")!, step: 20)
        let i2 = House(id: "11", name: "ZBOX One Controller", price: 60, image: UIImage(named: "i2")!, noimage: UIImage(named: "nt2")!, step: 5)
        let i3 = House(id: "12", name: "Rubix Cube", price: 25, image: UIImage(named: "i3")!, noimage: UIImage(named: "nt3")!, step: 5)
        let i4 = House(id: "13", name: "Like Cap", price: 20, image: UIImage(named: "i4")!, noimage: UIImage(named: "nt4")!, step: 5)
        let i5 = House(id: "14", name: "Gunko Pop", price: 15, image: UIImage(named: "i5")!, noimage: UIImage(named: "nt5")!, step: 5)
        let i6 = House(id: "15", name: "Fork of truth (RARE)", price: 80000000, image: UIImage(named: "i6")!, noimage: UIImage(named: "nt6")!, step: 5)
        let i7 = House(id: "16", name: "Bintendo Switch", price: 350, image: UIImage(named: "i7")!, noimage: UIImage(named: "nt7")!, step: 20)
        let i8 = House(id: "17", name: "iGhone X Pro Max", price: 1200, image: UIImage(named: "i8")!, noimage: UIImage(named: "nt8")!, step: 40)
        let i9 = House(id: "18", name: "Gamsung Galaxy S21", price: 1000, image: UIImage(named: "i9")!, noimage: UIImage(named: "nt9")!, step: 20)
        let i10 = House(id: "19", name: "Itemis AG", price: 3000000, image: UIImage(named: "i10")!, noimage: UIImage(named: "nt10")!, step: 2500)
       
        
        houses.append(h1)
        houses.append(h2)
        houses.append(h3)
        houses.append(h4)
        houses.append(h5)
        houses.append(h6)
        houses.append(h7)
        houses.append(h8)
        houses.append(h9)
        houses.append(i1)
        houses.append(i2)
        houses.append(i3)
        houses.append(i4)
        houses.append(i5)
        houses.append(i6)
        houses.append(i7)
        houses.append(i8)
        houses.append(i9)
        houses.append(i10)
        
    }
    
    func mapHousesintoarray() {
        let defaults = UserDefaults.standard
        
        
        var array = defaults.object(forKey:"costsofhouses") as? [Int] ?? [Int]()
        
        var bereitseingefuegt = array.count
        
        var currentindexzaehler = 1
        
        for haus in houses {
            if(bereitseingefuegt >= currentindexzaehler) {
                
            } else {
                array.append(haus.price!)
            }
            currentindexzaehler += 1
        }
        
        defaults.set(array, forKey: "costsofhouses")
        
    }
    
}
