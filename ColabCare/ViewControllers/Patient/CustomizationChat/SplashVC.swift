//
//  ChatVC.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/5/21.
//

import UIKit
import ChatSDK
import MBProgressHUD
import FirebaseFirestore
class SplashVC: BSplashScreenViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
       pushLoginViewController()
    }
    
    override func pushMainViewController() {
        if loginFlag {
            if userIndex == 0 {
            moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Provider, nextVC: "ProviderTabBarViewController")
            } else {
                if NetworkReachabilityManager()!.isReachable {
                db.collection("user_data").document(BChatSDK.currentUser().entityID()).setData(["email":BChatSDK.currentUser().email()!, "name":BChatSDK.currentUser().name()!, "phone":"" , "type": "PATIENT"])
                } else {
                    showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
                }
                moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Main, nextVC: KEY.VIEWCONTROLLER.TabBarViewController)
            }
        }
    }
}
