import UIKit
class ProviderTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // tell our UITabBarController subclass to handle its own delegate methods
        self.delegate = self
        tabBarController?.selectedIndex = 1
    }

    // called whenever a tab button is tapped
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            print("First tab")
           // fromHome = -1
            self.tabBar.isHidden = false
        } else if tabBarIndex == 1 {
           // fromHome = 1
            self.tabBar.isHidden = false
        } else if tabBarIndex == 2 {
            print("Third tab")
            self.tabBar.isHidden = false
        } else if tabBarIndex == 3 {
            print("Four tab")
            self.tabBar.isHidden = false
        } else if tabBarIndex == 4 {
            self.tabBar.isHidden = false
        }
    }

    // alternate method if you need the tab bar item
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // ...
    }
}

