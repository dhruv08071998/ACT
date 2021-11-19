//
//  LoginVC.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/13/21.
//

import UIKit
import ChatSDK
class LoginVC: BLoginViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackground(view: view)
        btnCheckBox.setImage(UIImage(named: "checkbox_blank"), for: .normal)
        termsAndConditionsButton.isHidden = true
        chatImageView.image = UIImage(named: "AppIcon_transperant")!
        registerButton.isHidden = true
        forgotPasswordButton.isHidden = true
        titleLabel.isHidden = true
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 30))
        view.addConstraint(NSLayoutConstraint(item: chatImageView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 40))
        if userIndex == 0 {
            lblUserType.text = "Provider Mode"
        } else {
            lblUserType.text = "Patient Mode"
        }
        if themeFlag == 1 {
            loginButton.backgroundColor = #colorLiteral(red: 0.5098039216, green: 0.6784313725, blue: 0.662745098, alpha: 1)
        } else if themeFlag == 2 {
            loginButton.backgroundColor = #colorLiteral(red: 0.6862745098, green: 0.5568627451, blue: 0.7098039216, alpha: 1)
        } else {
            loginButton.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
        }
    }
    
    override func changeFlag() {
        loginFlag = true
    }
    
    override func getuserType() -> String! {
        if userIndex == 0{
            return "PROVIDER"
        }
        return "PATIENT"
    }
    override func wantToChangeUserTypeTapped(_ sender: Any!) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.UserTypeViewController)
    }
    
    override func btnCheckBoxTapped(_ sender: Any!) {
        if btnCheckBox.currentImage == UIImage(named: "checkbox_blank") {
            btnCheckBox.setImage(UIImage(named: "checkbox_fill"), for: .normal)
        } else {
            btnCheckBox.setImage(UIImage(named: "checkbox_blank"), for: .normal)
        }
        
    }
    override func btnTermsTapped(_ sender: Any!) {
        showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.disclaimer_message)
    }
    
}
