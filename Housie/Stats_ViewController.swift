//
//  Stats_ViewController.swift
//  Housie
//
//  Created by Alpay Kücük on 03.08.21.
//

import Foundation
import UIKit
import SideMenu
import FSCalendar

class Stats_ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    
    @IBOutlet weak var loanspayed_label: UILabel!
    @IBOutlet weak var timebeeingfocused_label: UILabel!
    @IBOutlet weak var currentdate_label: UILabel!
    @IBOutlet weak var calender: FSCalendar!
    var menu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuManager.default.leftMenuNavigationController
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)

        calender.delegate = self
        calender.dataSource = self
        calender.select(Date())
        currentdate_label.text = getStringDate(currentdate: calender.selectedDate!)
        
        loanspayed_label.text = AppDelegate.currentUser?.getEventFromEventslist(eventstring: getStringDate(currentdate: calender.selectedDate!)).payedloan.description
        let extractedExpr = AppDelegate.currentUser?.getEventFromEventslist(eventstring: getStringDate(currentdate: calender.selectedDate!)).spendtime
        let extractedExpr1 = (Float(extractedExpr!) / 60).rounded()
        timebeeingfocused_label.text = Int(extractedExpr1).description
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        currentdate_label.text = getStringDate(currentdate: date)
        loanspayed_label.text = AppDelegate.currentUser?.getEventFromEventslist(eventstring: getStringDate(currentdate: date)).payedloan.description
        let extractedExpr = AppDelegate.currentUser?.getEventFromEventslist(eventstring: getStringDate(currentdate: date)).spendtime
        let extractedExpr1 = (Float(extractedExpr!) / 60).rounded()
        timebeeingfocused_label.text = Int(extractedExpr1).description

    }
    
    @IBAction func openmenu(_ sender: Any) {
        menu = SideMenuManager.default.leftMenuNavigationController
        self.present(menu!, animated: true) {
            
        }
    }
    
}

extension UIViewController {
    func getStringDate(currentdate: Date) -> String{
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "d MMM y"
        return formatter3.string(from: currentdate)
    }
}
