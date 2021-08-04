import UIKit
import SideMenu
import UIGradient
import GoogleMobileAds
import BLTNBoard

class ViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!
    lazy var bulletinManager: BLTNItemManager = {
        
        let page = BLTNPageItem(title: "Time to pay off these loans!")
        page.image = #imageLiteral(resourceName: "h2")

        page.descriptionText = "Focus on your tasks while paying off loans of houses of famous people!"
        page.actionButtonTitle = "Let's start"
        page.actionHandler = { (item: BLTNActionItem) in
            self.vibratePhone()
            item.manager?.dismissBulletin(animated: true)
        }
        let rootItem: BLTNItem = page
        return BLTNItemManager(rootItem: rootItem)
        }()

    
    var menu: SideMenuNavigationController?
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)

        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self


        
        self.view.backgroundColor = UIColor.fromGradientWithDirection(.topToBottom, frame: self.view.frame, colors: [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)])
        //view1.backgroundColor = UIColor.fromGradient(gradient, frame: frame)
        
        let menuview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menu") as! Menu_ViewController
        
        menu = SideMenuNavigationController(rootViewController: menuview)
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: true)
        
        SideMenuManager.default.leftMenuNavigationController = menu!
        //SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)
        
        let menuviessw = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tasks_vc") as! Tasks_ViewController
        
        menuviessw.willMove(toParent: self)
        menuviessw.view.frame = containerView.bounds
        containerView.addSubview(menuviessw.view)
        addChild(menuviessw)
        menuviessw.didMove(toParent: self)
        
        
        showOnBoarding()
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
    
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      bannerView.alpha = 0
      UIView.animate(withDuration: 1, animations: {
        bannerView.alpha = 1
      })
    }
    
    @IBAction func openMenu() {
        
        present(menu!, animated: true) {
            
        }
        
    }
    
    func showOnBoarding() {
        let defaults = UserDefaults.standard
        let firsttime = defaults.bool(forKey: "firsttime")
        
        if firsttime {
            //defaults.setValue(false, forKey: "firsttime")
            vibratePhoneMedium()
            bulletinManager.showBulletin(above: self)

        }
        
    }
    
    
}
