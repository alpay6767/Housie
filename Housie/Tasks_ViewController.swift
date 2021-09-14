import UIKit
import SideMenu
import UIGradient
import CountdownLabel
import BLTNBoard


class Tasks_ViewController: UIViewController, CountdownLabelDelegate, LTMorphingLabelDelegate {
    
    lazy var bulletinManager: BLTNItemManager = {
        
        let page = BLTNPageItem(title: "Loan paying started! " + " 🥳")
        page.image = #imageLiteral(resourceName: "working")

        page.descriptionText = "Every 20 seconds 1000$ will be payed off! Good luck on all your tasks. You can do it! ✊"
        page.actionButtonTitle = "Let's Go"
        page.actionHandler = { (item: BLTNActionItem) in
            self.vibratePhone()
            item.manager?.dismissBulletin(animated: true)
        }
        let rootItem: BLTNItem = page
        return BLTNItemManager(rootItem: rootItem)
        }()
 
    @IBOutlet weak var hauscosts: UILabel!
    @IBOutlet weak var hausname: UILabel!
    @IBOutlet weak var hausimage: UIImageView!
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var coins: UILabel!
    let modeldata = ModelData()
    
    @IBOutlet weak var startbtn: UIButton!
    var currentHaus: House?
    
    static var active = true
    static var selecteHouseIndex = 0
    
    @IBOutlet weak var label: CountdownLabel!
    var menu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuManager.default.leftMenuNavigationController
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)

        self.view.backgroundColor = UIColor.fromGradientWithDirection(.topLeftToBottomRight, frame: self.view.frame, colors: [#colorLiteral(red: 0.6737607926, green: 0.8173010181, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2793725758, green: 0.4030943474, blue: 0.7568627596, alpha: 1)])
        
        label.setCountDownTime(minutes: 60*25)
        label.font = UIFont(name:"CaviarDreams", size:50)
        label.delegate = self
        label.pause()

        //label.start()
        
        //setcurrent hause:
        currentHaus = AppDelegate.currentUser?.listOfHouses[Tasks_ViewController.selecteHouseIndex]
        
        label.countdownDelegate = self
        coins.text = AppDelegate.currentUser?.coins!.description
        hausname.text = currentHaus!.name
        hauscosts.text = (currentHaus!.price!.description) + "$" + " / " + (currentHaus!.remainingPrice!.description) + "$"
        hausimage.image = currentHaus?.image

        
    }
    
    @IBAction func start(_ sender: Any) {
        // check if pause or not
        vibratePhone()
        vibratePhoneMedium()
        
        if !label.isPaused{
            // timer pause
            bg.image = UIImage(named: "bgwithclouds")
            startbtn.setImage(UIImage(named: "startbtn"), for: .normal)
            label.pause()
            
            /*let notiData = HDNotificationData(
                iconImage: UIImage(systemName: "clock.fill")?.withTintColor(.black),
                        appTitle: "Housie".uppercased(),
                title: "Loan paying stopped!" + " 😯",
                        message: "Cmon don't give up! You can always start it again! 💪",
                        time: "now")
                    
            HDNotificationView.show(data: notiData, onTap: nil, onDidDismiss: nil)*/
                            
                let page = BLTNPageItem(title: "Coffee break time! " + " 🥳")
                page.image = #imageLiteral(resourceName: "pause")

                page.descriptionText = "Don't forget to take breaks! You can start paying the loans again!"
                page.actionButtonTitle = "Have a break"
                page.actionHandler = { (item: BLTNActionItem) in
                    self.vibratePhone()
                    item.manager?.dismissBulletin(animated: true)
                }
                let rootItem: BLTNItem = page
            
            bulletinManager = BLTNItemManager(rootItem: rootItem)
            bulletinManager.showBulletin(above: self)
            //bulletinManager.push(item: rootItem)

            
        } else {
            // timer start
            bg.image = UIImage(named: "bg_active")
            startbtn.setImage(UIImage(named: "stopbtn"), for: .normal)
            label.start()
            
            /*let notiData = HDNotificationData(
                iconImage: UIImage(systemName: "clock.fill")?.withTintColor(.black),
                        appTitle: "Housie".uppercased(),
                title: "Loan paying started! " + " 🥳",
                        message: "Good luck on all your tasks. You can do it! ✊",
                        time: "now")
                    
            HDNotificationView.show(data: notiData, onTap: nil, onDidDismiss: nil)
 */
            
            let page = BLTNPageItem(title: "Loan paying started! " + " 🥳")
            page.image = #imageLiteral(resourceName: "working")

            page.descriptionText = "Every 20 seconds " + currentHaus!.step!.description + "$ will be payed off! Good luck on all your tasks. You can do it! ✊"
            page.actionButtonTitle = "Let's Go"
            page.actionHandler = { (item: BLTNActionItem) in
                self.vibratePhone()
                item.manager?.dismissBulletin(animated: true)
            }
            let rootItem: BLTNItem = page
            
            bulletinManager = BLTNItemManager(rootItem: rootItem)
            bulletinManager.showBulletin(above: self)
        }
        
    }
    @IBAction func timerdown(_ sender: Any) {
        label.addTime(time: -60.0)
    }
    
    @IBAction func timerup(_ sender: Any) {
        label.addTime(time: 60.0)
    }
    
    
    @IBAction func back(_ sender: Any) {
        menu = SideMenuManager.default.leftMenuNavigationController
        self.present(menu!, animated: true) {
            
        }
        //showTimeCountedAlert()
        
    }
    
    func showTimeCountedAlert() {
        let alert = UIAlertController(title: "Your total time counted", message: label!.timeCounted.description, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    
    
    func countingAt(timeCounted: TimeInterval, timeRemaining: TimeInterval) {
        //print("Time Counted: " + timeCounted.description)
        
        if (!Tasks_ViewController.active) {
            label.cancel()
        } else {
        
            let modulo = Int(timeCounted)%20
            print(modulo.description)
        
            if modulo == 0 && timeCounted != 0 {
                updateView()
            }
        
            
            AppDelegate.currentUser?.addOrUpdateEvent(additionaltime: 1, additionalpayment: 0, date: getStringDate(currentdate: Date()))
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        label.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.pause()
    }
 
    func updateView() {
        
        if currentHaus?.remainingPrice == 0 {
            //nothing
        } else {
        
            currentHaus?.remainingPrice = (currentHaus?.remainingPrice)!-currentHaus!.step!
        if (currentHaus?.remainingPrice)! <= 0 {
            currentHaus?.remainingPrice = 0
            
            let page = BLTNPageItem(title: currentHaus!.name! + " is finally payed! " + " 🥳")
            page.image = #imageLiteral(resourceName: "working")

            page.descriptionText = "You completly payed the loans for it! You are insane ✊"
            page.actionButtonTitle = "Nice"
            page.actionHandler = { (item: BLTNActionItem) in
                self.vibratePhone()
                item.manager?.dismissBulletin(animated: true)
            }
            let rootItem: BLTNItem = page
            
            bulletinManager = BLTNItemManager(rootItem: rootItem)
            bulletinManager.showBulletin(above: self)
            
        }
        hauscosts.text = (currentHaus!.price!.description) + "$" + " / " + (currentHaus!.remainingPrice!.description) + "$"
        mapHousesintoarray()
            AppDelegate.currentUser?.addOrUpdateEvent(additionaltime: 0, additionalpayment: currentHaus!.step!, date: getStringDate(currentdate: Date()))
        }
        
    }
    
    func mapHousesintoarray() {
        let defaults = UserDefaults.standard
        var array = [Int]()

        for haus in AppDelegate.currentUser!.listOfHouses {
            array.append(haus.remainingPrice!)
        }
        
        defaults.set(array, forKey: "costsofhouses")
        
    }
    
    
    
    
}


