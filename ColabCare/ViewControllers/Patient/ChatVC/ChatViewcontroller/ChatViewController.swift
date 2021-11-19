//
//  ChatViewController.swift
//  ColabCare
//
//  Created by Dhruv Upadhyay on 09/03/21.
//

import UIKit
import ChatSDK
class ChatViewController: UIViewController {
    
    @IBOutlet weak var constraintTopTableView: NSLayoutConstraint!
    var viewController = UIViewController()
    
    @IBOutlet weak var imgEmergency: UIImageView!
    @IBOutlet weak var lblEmergency2: UILabel!
    
    @IBOutlet weak var lblEmergency1: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    static var cView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated:true)
        changeBackground(view: self.view)
        viewController = BChatSDK.ui().privateThreadsViewController()
        embed(viewController, inView: viewContainer)
        ChatViewController.cView = viewContainer
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.applicationIconBadgeNumber = 0
        if UserDefineBtn.color != themeColor{
            changeBackground(view: self.view)
        }
        if userIndex == 0{
            lblEmergency2.isHidden = true
            lblEmergency1.isHidden = true
            imgEmergency.isHidden = true
            constraintTopTableView.constant = -140
        }
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
extension UIViewController {
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
