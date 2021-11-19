//
//  LoginViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 5/23/21.
//

import UIKit
import Firebase
import SVProgressHUD
class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var txtPassword: PaddedTextField!
    @IBOutlet weak var txtEmail: PaddedTextField!
    var isPassSecure = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        btnEye.addTarget(self, action: #selector(btnEyePasswordTapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { [self] (user, error) in
            if error == nil{
                let userDefaults = UserDefaults.standard
                do {
                    let encodedData: Data =  try NSKeyedArchiver.archivedData(withRootObject: txtEmail.text!, requiringSecureCoding: false)
                    userDefaults.set(encodedData, forKey: KEY.USERDEFAULT.email)
                    userDefaults.synchronize()
                    storeTheme()
                    SVProgressHUD.dismiss()
                } catch {
                }
                self.moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Main, nextVC: KEY.VIEWCONTROLLER.TabBarViewController)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func btnRegisterTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: "Authentication", nextVC: "RegisterViewController")
    }
    
    @objc func btnEyePasswordTapped(_ sender: UIButton) {
        isPassSecure = !isPassSecure
        if isPassSecure {
            btnEye.setImage(UIImage(named: KEY.BUTTONTITLE.btnPasswordNotProtected), for: .normal)
            // isPassSecure = false
            txtPassword.isSecureTextEntry.toggle()
        } else {
            btnEye.setImage(UIImage(named: KEY.BUTTONTITLE.btnPasswordProtected), for: .normal)
            txtPassword.isSecureTextEntry.toggle()
            
        }
    }
}
