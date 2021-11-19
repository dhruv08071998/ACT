//
//  RegisterViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 5/23/21.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var btnEyeConfirmPassword: UIButton!
    @IBOutlet weak var btnEyePassword: UIButton!
    @IBOutlet weak var txtConfirmPassword: PaddedTextField!
    @IBOutlet weak var txtPassword: PaddedTextField!
    @IBOutlet weak var txtEmail: PaddedTextField!
    var isPassSecure = false
    var isConPassSecure = false
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEyePassword.addTarget(self, action: #selector(btnEyePasswordTapped(_:)), for: .touchUpInside)
        btnEyeConfirmPassword.addTarget(self, action: #selector(btnEyeConPassTapped(_:)), for: .touchUpInside)
    }
    
    @objc func btnEyePasswordTapped(_ sender: UIButton) {
        isPassSecure = !isPassSecure
        if isPassSecure {
            btnEyePassword.setImage(UIImage(named: KEY.BUTTONTITLE.btnPasswordNotProtected), for: .normal)
            // isPassSecure = false
            txtPassword.isSecureTextEntry.toggle()
        } else {
            btnEyePassword.setImage(UIImage(named: KEY.BUTTONTITLE.btnPasswordProtected), for: .normal)
            txtPassword.isSecureTextEntry.toggle()
            
        }
    }
    
    @objc func btnEyeConPassTapped(_ sender: UIButton) {
        isConPassSecure = !isConPassSecure
        if isConPassSecure {
            btnEyeConfirmPassword.setImage(UIImage(named: KEY.BUTTONTITLE.btnPasswordNotProtected), for: .normal)
            // isPassSecure = false
            txtConfirmPassword.isSecureTextEntry.toggle()
        } else {
            btnEyeConfirmPassword.setImage(UIImage(named: KEY.BUTTONTITLE.btnPasswordProtected), for: .normal)
            txtConfirmPassword.isSecureTextEntry.toggle()
            
        }
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        moveTobackScreen()
    }
    
    @IBAction func btnRegisterTapped(_ sender: Any) {
        if txtEmail.text!.isEmpty {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: "Please Enter Email")
        }
        else if txtPassword.text != txtConfirmPassword.text {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: "Password and Confirm Password does not Matched")
        }
        else{
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!){ (user, error) in
                if error == nil {
                    self.showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.registered_successfully)
                    self.moveTobackScreen()
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
}
