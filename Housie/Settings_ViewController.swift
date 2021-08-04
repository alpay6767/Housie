//
//  Settings_ViewController.swift
//  Housie
//
//  Created by Alpay Kücük on 03.08.21.
//

import Foundation
import UIKit
import SideMenu
import BLTNBoard

class Settings_ViewController: UIViewController {
    
    var menu: SideMenuNavigationController?

    let bulletinManager: BLTNItemManager = {
        
        let page = BLTNPageItem(title: "Thanks for using Housie!")
        page.image = #imageLiteral(resourceName: "sitting")

        page.descriptionText = "Keep producing instead of consuming! You got this"
        page.actionButtonTitle = "Got it!"
        page.actionHandler = { (item: BLTNActionItem) in
            item.manager?.dismissBulletin(animated: true)
        }
        let rootItem: BLTNItem = page
        return BLTNItemManager(rootItem: rootItem)
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuManager.default.leftMenuNavigationController
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)

        
        
    }
    
}
