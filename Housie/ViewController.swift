import UIKit
import SideMenu
import UIGradient

class ViewController: UIViewController {
    
    var menu: SideMenuNavigationController?
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    
    @IBAction func openMenu() {
        
        present(menu!, animated: true) {
            
        }
        
    }
    
}
