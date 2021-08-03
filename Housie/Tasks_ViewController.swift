import UIKit
import SideMenu
import UIGradient
import CountdownLabel

class Tasks_ViewController: UIViewController, CountdownLabelDelegate, LTMorphingLabelDelegate {
 
    @IBOutlet weak var hauscosts: UILabel!
    @IBOutlet weak var hausname: UILabel!
    @IBOutlet weak var hausimage: UIImageView!
    @IBOutlet weak var coins: UILabel!
    let modeldata = ModelData()
    
    @IBOutlet weak var startbtn: UIButton!
    var currentHaus: House?
    
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

        //label.start()
        
        //setcurrent hause:
        currentHaus = AppDelegate.currentUser?.listOfHouses[0]
        
        label.countdownDelegate = self
        coins.text = AppDelegate.currentUser?.coins!.description
        hausname.text = currentHaus!.name
        hauscosts.text = (currentHaus!.price!.description) + " / " + (currentHaus!.remainingPrice!.description)

        
    }
    
    @IBAction func start(_ sender: Any) {
        // check if pause or not
        if label.isPaused {
            // timer start
            startbtn.setImage(UIImage(named: "stopbtn"), for: .normal)
            label.start()
        } else {
            // timer pause
            startbtn.setImage(UIImage(named: "startbtn"), for: .normal)
            label.pause()
        }
        
    }
    @IBAction func timerdown(_ sender: Any) {
        label.addTime(time: -60)
    }
    
    @IBAction func timerup(_ sender: Any) {
        label.addTime(time: 60)
    }
    
    
    @IBAction func back(_ sender: Any) {
        menu = SideMenuManager.default.leftMenuNavigationController
        self.present(menu!, animated: true) {
            
        }
        showTimeCountedAlert()
        
    }
    
    func showTimeCountedAlert() {
        let alert = UIAlertController(title: "Your total time counted", message: label!.timeCounted.description, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    
    
    func countingAt(timeCounted: TimeInterval, timeRemaining: TimeInterval) {
        //print("Time Counted: " + timeCounted.description)
        
        let modulo = Int(timeCounted)%20
        print(modulo.description)
        
        if modulo == 0 {
            updateView()
        }
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        label.cancel()
    }
 
    func updateView() {
        currentHaus?.remainingPrice = (currentHaus?.remainingPrice)!-1000
        hauscosts.text = (currentHaus!.price!.description) + " / " + (currentHaus!.remainingPrice!.description)
        mapHousesintoarray()
        
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


