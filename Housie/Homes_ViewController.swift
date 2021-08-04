//
//  Homes_ViewController.swift
//  Housie
//
//  Created by Alpay Kücük on 03.08.21.
//

import Foundation
import UIKit
import SideMenu
import BLTNBoard


class Homes_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let bulletinManager: BLTNItemManager = {
        
        let page = BLTNPageItem(title: "Time to focus!")
        page.image = #imageLiteral(resourceName: "work2")

        page.descriptionText = "While you do productive stuff the loan will be payed off 💵"
        page.actionButtonTitle = "Got it!"
        page.actionHandler = { (item: BLTNActionItem) in
            item.manager?.dismissBulletin(animated: true)
        }
        let rootItem: BLTNItem = page
        return BLTNItemManager(rootItem: rootItem)
        }()
    
    
 
    
    @IBOutlet weak var pagecontrol: UIPageControl!
    @IBOutlet weak var houses_cv: UICollectionView!
    var menu: SideMenuNavigationController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuManager.default.leftMenuNavigationController
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)
        houses_cv.delegate = self
        houses_cv.dataSource = self

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = AppDelegate.currentUser!.listOfHouses.count
        return AppDelegate.currentUser!.listOfHouses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "housecell", for: indexPath) as! HouseCell
        let currenthouse = AppDelegate.currentUser!.listOfHouses[indexPath.item]
        
        cell.infoview.clipsToBounds = true
        cell.infoview.layer.cornerRadius = 15
        cell.image.image = currenthouse.image
        cell.name.text = currenthouse.name
        
        var f1 = Float(currenthouse.remainingPrice!)
        var f2 = Float(currenthouse.price!)
        let extractedExpr: Float = f1/f2
        let progress = extractedExpr * 100.0
        let uebrig = 100.0 - progress
        cell.progress_circle.startProgress(to: CGFloat(uebrig), duration: 2)
        
        cell.startplayingbtn.tag = indexPath.row
            cell.startplayingbtn.addTarget(self,
                action: #selector(startplaying(sender:)),
                for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func startplaying(sender: UIButton)
        {
        vibratePhone()
        Tasks_ViewController.selecteHouseIndex = sender.tag
        
        /*let notiData = HDNotificationData(
            iconImage: UIImage(systemName: "paperclip")?.withTintColor(.black),
                    appTitle: "Housie".uppercased(),
            title: AppDelegate.currentUser!.listOfHouses[sender.tag].name! + " was selected" + " 🏠",
                    message: "Pay the loan to get an exclusive Badge 💵",
                    time: "now")
                
        HDNotificationView.show(data: notiData, onTap: nil, onDidDismiss: nil)
 */
        
        
        
        bulletinManager.showBulletin(above: self)
        
        }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pagecontrol.currentPage = indexPath.item

    }
    @IBAction func openmenu(_ sender: Any) {
        menu = SideMenuManager.default.leftMenuNavigationController
        self.present(menu!, animated: true) {
            
        }
    }
    
}


extension UIViewController {
    
    func vibratePhone() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
    }
    func vibratePhoneMedium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
    }
    
}
