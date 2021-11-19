//
//  MyProfileViewController.swift
//  ZollEnproAedlink
//
//  Created by Devarshi Pandya on 5/29/20.
//  Copyright © 2020 Devarshi Pandya. All rights reserved.
//

import UIKit
import ChatSDK
import SDWebImage
class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    @IBOutlet var tblViewProfile: UITableView!
    @IBOutlet var imgViewUserProfile: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblUserEmail: UILabel!
    var flag = false
    
    
    var arrModule: [[String: Any]] = [[KEY.PROFILE.IMG: "art_palette", KEY.PROFILE.NAME: "Change Theme", KEY.PROFILE.DESC: ""],
                                      [KEY.PROFILE.IMG: "iconLogout", KEY.PROFILE.NAME: "Logout", KEY.PROFILE.DESC: ""]]
    //[KEY.PROFILE.IMG: "iconPassword", KEY.PROFILE.NAME: "Change Password", KEY.PROFILE.DESC: ""],
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  changeBackground(view: self.view)
    }
    
    override func viewDidLayoutSubviews() {
        imgViewUserProfile.layer.cornerRadius = imgViewUserProfile.frame.height/2
        imgViewUserProfile.layer.borderWidth = 1
        imgViewUserProfile.layer.borderColor = #colorLiteral(red: 0.007843137255, green: 0.4941176471, blue: 0.7647058824, alpha: 1)
        imgViewUserProfile.layer.masksToBounds = false
        imgViewUserProfile.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeBackground(view: self.view)
        if NetworkReachabilityManager()!.isReachable {
        db.collection("user_data").document(BChatSDK.currentUser().entityID()).updateData(["email":BChatSDK.currentUser().email()!, "name":BChatSDK.currentUser().name()!, "phone":"" , "type": "PATIENT"])
        NavigationHeaderView.updateView(view: viewNavigation)
        } else {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
        }
        NavigationHeaderView.updateView(view: viewNavigation)
        if BChatSDK.currentUser() != nil {
            lblUserEmail.text = BChatSDK.currentUser().email()!
            imgViewUserProfile.sd_setImage(with: URL(string:BChatSDK.currentUser().imageURL()), placeholderImage: UIImage(named: "user"))
            lblUserName.text = BChatSDK.currentUser().name()!
        } else {
            lblUserEmail.text = retriveCurrentUser().email!
            imgViewUserProfile.sd_setImage(with: URL(string: retriveCurrentUser().profileURL!))
            lblUserName.text = retriveCurrentUser().username!
        }
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditUserProfileViewController") as! EditUserProfileViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // if tab changes then this profile screen automatically popover current vc
        //        if !flag {
        //        moveTobackScreen()
        //        }
    }
    
}

extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrModule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileCell = tblViewProfile.dequeueReusableCell(withIdentifier: KEY.CELL.ProfileTableViewCell) as? ProfileTableViewCell
        let dictData = arrModule[indexPath.row]
        profileCell!.imgViewModule.image = UIImage(named: (dictData[KEY.PROFILE.IMG] as? String)!)
        profileCell!.lblModule.text = dictData[KEY.PROFILE.NAME] as? String
        profileCell?.lblDesc.text = ""
        if dictData[KEY.PROFILE.NAME] as? String == "Logout" {
            profileCell!.lblModule.textColor = #colorLiteral(red: 1, green: 0.3450980392, blue: 0.3450980392, alpha: 1)
            profileCell!.lblModule.font = UIFont(name: KEY.FONT.FUTURABOLD, size: 18.0)
        }
        return profileCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrModule[indexPath.row][KEY.PROFILE.NAME] as? String == "Change Theme" {
            moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ChangeThemeViewController)
            flag = true
        }
        if arrModule[indexPath.row][KEY.PROFILE.NAME] as? String == "Change Password" {
            
        }
        if arrModule[indexPath.row][KEY.PROFILE.NAME] as? String == "Logout"{
            UserDefaults.standard.removeObject(forKey: KEY.USERDEFAULT.email)
            UserDefaults.standard.removeObject(forKey: KEY.USERDEFAULT.currentUser)
            UserDefaults.standard.removeObject(forKey: KEY.USERDEFAULT.dailyQues)
            userIndex = 0
            //            BChatSDK.ui().setLoginViewController(lVC)
            BChatSDK.auth().logout()
            //let pc = BChatSDK.ui().splashScreenNavigationController()
            let storyboard = UIStoryboard(name: KEY.STORYBOARD.Authentication, bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.UserTypeViewController)
            UIApplication.shared.windows.first?.rootViewController = initialViewController
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

