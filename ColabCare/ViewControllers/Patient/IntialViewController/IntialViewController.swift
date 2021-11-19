//
//  IntialViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 5/23/21.
//

import UIKit
import ChatSDK
class IntialViewController: UIViewController {

    @IBOutlet weak var lblBlue: UILabel!
    @IBOutlet weak var lblGreen: UILabel!
    @IBOutlet weak var lblPurple: UILabel!
    @IBOutlet weak var checkBtnBlue: UIButton!
    @IBOutlet weak var checkBtnGreen: UIButton!
    @IBOutlet weak var checkBtnPurple: UIButton!
    @IBOutlet weak var viewGreen: UIView!
    @IBOutlet weak var viewBlue: UIView!
    @IBOutlet weak var viewPurple: UIView!
    var isCheckBlue = false
    var isCheckGreen = false
    var isCheckPurple = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewGreen.layer.borderWidth = 1
        viewGreen.layer.cornerRadius = 8
        viewGreen.layer.borderColor = .white()
        viewPurple.layer.borderWidth = 1
        viewPurple.layer.cornerRadius = 8
        viewPurple.layer.borderColor = .white()
        viewBlue.layer.borderWidth = 1
        viewBlue.layer.cornerRadius = 8
        viewBlue.layer.borderColor = .white()
        checkBtnBlue.addTarget(self, action: #selector(btnCheckBoxBlue(_:)), for: .touchUpInside)
        checkBtnGreen.addTarget(self, action: #selector(btnCheckBoxGreen(_:)), for: .touchUpInside)
        checkBtnPurple.addTarget(self, action: #selector(btnCheckBoxPurple(_:)), for: .touchUpInside)
        navigationController?.setNavigationBarHidden(true, animated:true)
        removeIfAlreadyUserExisted()
    }
    
    func removeIfAlreadyUserExisted() {
        if retriveCurrentUser().username != nil {
            UserDefaults.standard.removeObject(forKey: KEY.USERDEFAULT.currentUser)
            BChatSDK.auth().logout()
        }
    }
    @objc func btnCheckBoxBlue(_ sender: UIButton) {
        if isCheckBlue {
            sender.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckBlue = !isCheckBlue
        } else {
            sender.setImage(UIImage(named: "iconRadioCheck"), for: .normal)
            isCheckBlue = !isCheckBlue
            themeColor = lblBlue.backgroundColor
            checkBtnGreen.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckGreen = false
            checkBtnPurple.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckPurple = false
            themeFlag = 3
           
        }
    }
    @objc func btnCheckBoxGreen(_ sender: UIButton) {
        if isCheckGreen {
            sender.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckGreen = !isCheckGreen
        } else {
            sender.setImage(UIImage(named: "iconRadioCheck"), for: .normal)
            isCheckGreen = !isCheckGreen
            themeColor = lblGreen.backgroundColor
            checkBtnPurple.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckPurple = false
            checkBtnBlue.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckBlue = false
            themeFlag = 1
           
        }
    }
    @objc func btnCheckBoxPurple(_ sender: UIButton) {
        if isCheckPurple {
            sender.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckPurple = !isCheckPurple
        } else {
            sender.setImage(UIImage(named: "iconRadioCheck"), for: .normal)
            isCheckPurple = !isCheckPurple
            themeColor = lblPurple.backgroundColor
            checkBtnGreen.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckGreen = false
            checkBtnBlue.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            themeFlag = 2
            isCheckBlue = false
           
        }
    }
    
    
    @IBAction func btnProceedsTapped(_ sender: Any) {
        if !isCheckBlue  && !isCheckPurple && !isCheckGreen {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.select_one_theme)
        } else {
            moveToNextScreen(iPhoneStoryboad: "Authentication", nextVC: "LoginViewController")
        }
    }
    
}
