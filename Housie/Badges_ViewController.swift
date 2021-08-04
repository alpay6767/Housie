//
//  Badges_ViewController.swift
//  Housie
//
//  Created by Alpay Kücük on 03.08.21.
//

import Foundation
import UIKit
import SideMenu
import BLTNBoard


class Badges_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static var selectedHouse = AppDelegate.currentUser?.listOfHouses[0]
    
    let bulletinManager: BLTNItemManager = {
        
        
        
        let page = BLTNPageItem(title: "Collect every House by paying them off!")
        page.image = #imageLiteral(resourceName: "sitting")

        page.descriptionText = "Keep working and focusing on your tasks to pay off this house!"
        page.actionButtonTitle = "Lemme work!"
        page.actionHandler = { (item: BLTNActionItem) in
            item.manager?.dismissBulletin(animated: true)
        }
        let rootItem: BLTNItem = page
        return BLTNItemManager(rootItem: rootItem)
        }()
    
    @IBOutlet weak var badges_cv: UICollectionView!
    @IBOutlet weak var menubtn: UIButton!
    
    var menu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuManager.default.leftMenuNavigationController
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)

        badges_cv.delegate = self
        badges_cv.dataSource = self
        
        Badges_ViewController.selectedHouse = AppDelegate.currentUser?.listOfHouses[0]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = AppDelegate.currentUser!.listOfHouses.count
        return AppDelegate.currentUser!.listOfHouses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.width/3 + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "badgecell", for: indexPath) as! BadgeCell
        let currenthouse = AppDelegate.currentUser!.listOfHouses[indexPath.item]
        
        cell.name.text = currenthouse.name
        
        if (currenthouse.remainingPrice! <= 0) {
            cell.image.image = currenthouse.image
        } else {
            cell.image.image = currenthouse.noimage
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currenthouse = AppDelegate.currentUser!.listOfHouses[indexPath.item]
        Badges_ViewController.selectedHouse = currenthouse
        
        vibratePhone()
        bulletinManager.showBulletin(above: self)
    }
    
    @IBAction func openmenu(_ sender: Any) {
    }
}
