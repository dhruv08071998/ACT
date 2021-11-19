//
//  UserTypeViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/26/21.
//

import UIKit
import ChatSDK
class UserTypeViewController: UIViewController {

    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnNext: UserDefineBtn!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRole: UITextField!
    var datasource = [String]()
    var picker  = UIPickerView()
    var isPassSecure = false
    @IBOutlet weak var lblPassLine: UILabel!
    @IBOutlet weak var constraintTopNext: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtRole.delegate = self
        picker.delegate = self
        picker.dataSource = self
        datasource = [KEY.USERTYPE.Provider, KEY.USERTYPE.Patient]
        txtPassword.isSecureTextEntry = true
      removeIfAlreadyUserExisted()
    }
    
    func removeIfAlreadyUserExisted() {
            UserDefaults.standard.removeObject(forKey: KEY.USERDEFAULT.currentUser)
            BChatSDK.auth().logout()

    }
    

    
    @IBAction func btnNextTapped(_ sender: Any) {
        if txtRole.text == KEY.USERTYPE.Patient && txtPassword.isHidden == false {
            if txtPassword.text == KEY.PASSWORD.password{
                NotificationCenter.default.post(name: NSNotification.Name(KEY.NOTIFICATION.login),object: nil)
            } else {
                showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.validPassword)
            }
        } else {
        NotificationCenter.default.post(name: NSNotification.Name(KEY.NOTIFICATION.login),object: nil)
        }
    }
    
    @IBAction func btnPasswordTapped(_ sender: Any) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        UserDefineBtn.updateView(view: btnNext)
        changeBackground(view: view)
        btnEye.isHidden = true
        txtPassword.isHidden = true
        lblPassLine.isHidden = true
        constraintTopNext.constant = -20
    }
    
    func setupPicker(textField: UITextField) {
        var toolBar = UIToolbar()
        toolBar.sizeToFit()
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: KEY.PARAMETER.textColor)
        picker.autoresizingMask = .flexibleWidth
        picker.selectRow(0, inComponent:0, animated:true)
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubview(picker)
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: KEY.PARAMETER.done, style: .done, target: self, action: #selector(onDoneButtonTapped))]
        textField.inputAccessoryView = toolBar
        textField.inputView = picker
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        if txtRole.text == ""{
            pickerView(picker, didSelectRow: 0, inComponent: 0)
        }
        if txtRole.text == KEY.USERTYPE.Provider {
            btnEye.isHidden = false
            txtPassword.isHidden = false
            lblPassLine.isHidden = false
            constraintTopNext.constant = 30
            picker.selectRow(0, inComponent: 0, animated: true)
            userIndex = 0
        } else if txtRole.text == KEY.USERTYPE.Patient  {
            btnEye.isHidden = true
            txtPassword.isHidden = true
            lblPassLine.isHidden = true
            constraintTopNext.constant = -20
            picker.selectRow(0, inComponent: 0, animated: true)
            userIndex = 1
        }
        self.view.endEditing(true)
    }
    
}

extension UserTypeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datasource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datasource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtRole.text =  datasource[row]
    }
}

extension UserTypeViewController: UITextFieldDelegate  {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtRole {
            setupPicker(textField: txtRole)
        }
    }
}

