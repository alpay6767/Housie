//
//  Badge.swift
//  Housie
//
//  Created by Alpay Kücük on 04.08.21.
//

import Foundation
import UIKit

class Badge {
    
    var id: String?
    var beschreibung: String?
    var collected: Bool?
    
    init(id: String, beschreibung: String, collected: Bool) {
        self.id = id
        self.beschreibung = beschreibung
        self.collected = collected
    }
    
}
