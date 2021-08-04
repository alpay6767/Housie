//
//  HouseCell.swift
//  Housie
//
//  Created by Alpay Kücük on 03.08.21.
//

import Foundation
import UIKit
import UICircularProgressRing

class HouseCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var infoview: UIView!
    
    @IBOutlet weak var progress_circle: UICircularProgressRing!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var startplayingbtn: UIButton!
    
    
}
