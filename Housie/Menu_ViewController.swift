//
//  Menu_ViewController.swift
//  Housie
//
//  Created by Alpay Kücük on 03.08.21.
//

import Foundation
import UIKit
import SideMenu


class Menu_ViewController: UITableViewController {
    
    var selectedIndex = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //MARK: do something when user presses menu item!
        
        let nc = self.navigationController?.presentingViewController as! UINavigationController
        let ncroot = nc.viewControllers[0] as! ViewController
                
        
        let currentSide = ncroot.children[ncroot.children.count-1]
        print("CurrentChild: " + currentSide.description)
        if (currentSide is Tasks_ViewController) {
            let tasksvc = currentSide as! Tasks_ViewController
            tasksvc.label.cancel()
        }
        
        
        switch indexPath.row {
        case 0:
            /*
            let menuview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tasks_vc") as! Tasks_ViewController
            SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: {
                nc.popViewController(animated: false)
                nc.pushViewController(menuview, animated: false)

            })*/
            
            
            
            
            let menuview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tasks_vc") as! Tasks_ViewController
            
            SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: {
                
                menuview.willMove(toParent: ncroot)
                menuview.view.frame = ncroot.containerView.bounds
                ncroot.containerView.addSubview(menuview.view)
                ncroot.addChild(menuview)
                menuview.didMove(toParent: ncroot)
            })
            
            break

        case 1:
            
            let menuview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "badges_vc") as! Badges_ViewController
            SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: {
                
                menuview.willMove(toParent: ncroot)
                menuview.view.frame = ncroot.containerView.bounds
                ncroot.containerView.addSubview(menuview.view)
                ncroot.addChild(menuview)
                menuview.didMove(toParent: ncroot)
            })
            break
        case 2:
            
            let menuview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homes_vc") as! Homes_ViewController
            SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: {
                
                menuview.willMove(toParent: ncroot)
                menuview.view.frame = ncroot.containerView.bounds
                ncroot.containerView.addSubview(menuview.view)
                ncroot.addChild(menuview)
                menuview.didMove(toParent: ncroot)
            })
            break
        case 3:
            
            let menuview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settings_vc") as! Settings_ViewController
            SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: {
                
                menuview.willMove(toParent: ncroot)
                menuview.view.frame = ncroot.containerView.bounds
                ncroot.containerView.addSubview(menuview.view)
                ncroot.addChild(menuview)
                menuview.didMove(toParent: ncroot)
            })
            break
        default:
            print("ERROR: Selection of drawer element failed!")
        }
        
    }
    
}
