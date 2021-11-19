////
////  EditProfileViewController.swift
////  ZollEnproAedlink
////
////  Created by Devarshi Pandya on 6/1/20.
////  Copyright © 2020 Devarshi Pandya. All rights reserved.
////
//
//import UIKit
//import PhoneNumberKit
//
//class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ModalTransitionListenerForCountry, OTPTextFieldDelegate {
//    func popoverDismissedCountryPicker() {
//        countryFlag.image = UIImage(named: choosenCountryFlag.code)
//        txtContactNumber.text = choosenCountryFlag.dial_code + KEY.BLANKSPACE.Space
//        stringLen = txtContactNumber.text?.count
//        selectedFlag = choosenCountryFlag
//        imgVerifyPhone.isHidden = true
//        isMobileVerifyByphone = false
//    }
//    
//    @IBOutlet var constraintviewHeight: NSLayoutConstraint!
//    @IBOutlet var constraintThirdSeperatorTop: NSLayoutConstraint!
//    @IBOutlet var lblOTPViewHeading: UILabel!
//    @IBOutlet var txtVerifyEmail: PaddedTextField!
//    @IBOutlet var imgVerifyEmail: UIImageView!
//    @IBOutlet var btnSendOTPByEmail: UIButton!
//    @IBOutlet var constraintSecondSeperatorTop: NSLayoutConstraint!
//    @IBOutlet var constraintFirstSeperatorTop: NSLayoutConstraint!
//    @IBOutlet var txtOTP6: OTPTextField!
//    @IBOutlet var txtOTP5: OTPTextField!
//    @IBOutlet var txtOTP4: OTPTextField!
//    @IBOutlet var txtOTP3: OTPTextField!
//    @IBOutlet var txtOTP2: OTPTextField!
//    @IBOutlet var txtOTP1: OTPTextField!
//    @IBOutlet var imgUserProfile: UIImageView!
//    @IBOutlet var btnEditProfilePicture: UIButton!
//    @IBOutlet var viewTransperant: UIView!
//    @IBOutlet var scrollView: UIScrollView!
//    @IBOutlet var imgVerifyPhone: UIImageView!
//    var selectedFlag = Flag()
//    @IBOutlet var btnVerify: UIButton!
//    @IBOutlet var countryFlag: UIImageView!
//    @IBOutlet var imgVerifyPhoneFlag: UIImageView!
//    @IBOutlet var btnSendOTP: UIButton!
//    @IBOutlet var viewOTP: UIView!
//    var stringLen: Int?
//    @IBOutlet var btnResendOTP: UIButton!
//    @IBOutlet var lblTimerCountDown: UILabel!
//    @IBOutlet var txtVerifyContactNumber: PaddedTextField!
//    @IBOutlet var imgPhoneNumberCheck: UIImageView!
//    @IBOutlet var txtContactNumber: PaddedTextField!
//    // MARK: - Property Declaration
//    @IBOutlet weak var txtFirstName: PaddedTextField!
//    @IBOutlet weak var txtLastName: PaddedTextField!
//    @IBOutlet weak var txtEmail: PaddedTextField!
//    @IBOutlet weak var txtOrgnization: PaddedTextField!
//    @IBOutlet weak var lblFirstName: UILabel!
//    @IBOutlet weak var lblLastName: UILabel!
//    @IBOutlet weak var lblEmail: UILabel!
//    @IBOutlet weak var lblOrganization: UILabel!
//    @IBOutlet weak var lblContactNumber: UILabel!
//    @IBOutlet weak var lblHeader: UILabel!
//    var isProfilePictureUpdated = false
//    var seconds = 70
//    var timer = Timer()
//    var isMobileVerifyByphone = false
//    var isMobileVerifyByEmail = false
//    var activeTextField = UITextField()
//    var userOptedEmailVerification: Bool!
//    lazy var checkingEmailModel: CheckingEmailVM = {
//        return CheckingEmailVM()
//    }()
//    var countryCode: String = String()
//    let header = ["token": retriveLoginModel().data.jwtToken!] as [String: Any]
//    var displayHeight =  CGFloat()
//    
//    // variable contain phone and email value if they verified and using that we compare new Entered email and phone number and will show verified symbol.
//    var updateEmailPhoneValue = [KEY.PARAMETER.phone: KEY.BLANKSPACE.Space, KEY.PARAMETER.email: KEY.BLANKSPACE.Space]
//    
//    // MARK: - ViewController's Life Cycle
//    let phoneNumberKit = PhoneNumberKit()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupFields()
//        setupTextFieldFromData()
//        countryFlag.isUserInteractionEnabled = true
//        ModalTransitionMediatorForCountry.instance.setListener(listener: self)
//        do {
//            let phoneNumber = try phoneNumberKit.parse(txtContactNumber.text!)
//            let code = phoneNumber.countryCode
//            stringLen = ("+" + String(code) + KEY.BLANKSPACE.Space).count
//            txtContactNumber.text! = String(phoneNumber.numberString)
//            let objFlag = Flag(name: phoneNumber.regionID!, dial_code: "+" + "\(phoneNumber.countryCode)", code: phoneNumber.regionID!)
//            choosenCountryFlag = objFlag
//            countryFlag.image = UIImage(named: objFlag.code)
//        } catch {
//            let objFlag = Flag(name: KEY.OBJCOUNTRY.USA, dial_code: KEY.OBJCOUNTRY.PlusOne, code: KEY.OBJCOUNTRY.USCountry)
//            stringLen = (objFlag.dial_code + KEY.BLANKSPACE.Space).count
//            choosenCountryFlag = objFlag
//            countryFlag.image = UIImage(named: objFlag.code)
//        }
//        btnEditProfilePicture.addTarget(self, action: #selector(btnEditProfilePicture(_:)), for: .touchUpInside)
//        self.imgUserProfile.sd_setImage(with: URL(string: retriveLoginModel().data.user.profileURL ), placeholderImage: UIImage(named: KEY.PLACEHOLDER.userPlaceholder))
//        btnEditProfilePicture.layer.cornerRadius = 20
//        txtContactNumber.placeholder = "Contact Number"
//        txtContactNumber.delegate = self
//    }
//    
//    @IBAction func btnChangeCountryTapped(_ sender: UIButton) {
//        self.openCountrySelectionView()
//    }
//    
//    func openImagePicker() {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
//            let imag = UIImagePickerController()
//            imag.delegate = self
//            imag.sourceType = UIImagePickerController.SourceType.photoLibrary
//            imag.allowsEditing = false
//            self.present(imag, animated: true, completion: nil)
//        }
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        if let originalImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            let image: UIImage = UIImage(data: originalImage.jpeg(.low)!)!
//            imgUserProfile.image = image
//            isProfilePictureUpdated = true
//        }
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    @objc func btnEditProfilePicture(_ sender: UIButton) {
//        openActionSheet()
//        
//    }
//    
//    func openActionSheet() {
//        let alert: UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
//        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
//            _ in
//            self.openCamera()
//        }
//        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertAction.Style.default) {
//            _ in
//            self.openGallary()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//        }
//        alert.addAction(cameraAction)
//        alert.addAction(gallaryAction)
//        alert.addAction(cancelAction)
//        alert.popoverPresentationController?.sourceView = self.btnEditProfilePicture.imageView
//        alert.popoverPresentationController?.sourceRect = self.btnEditProfilePicture.frame
//        self.present(alert, animated: true, completion: nil)
//        
//    }
//    
//    // MARK: - Button Tapped
//    @IBAction func btnSaveTapped(_ sender: Any) {
//        if txtFirstName.text!.isEmpty {
//            // MARK: sender specify the particular error lable.
//            showError(message: KEY.Message.FirstNameMissing, sender: lblFirstName, txtField: txtFirstName)
//            scrollView.setContentOffset(CGPoint(x: 0, y: (txtFirstName.superview?.frame.origin.y)!), animated: true)
//            return
//        }
//        if txtLastName.text!.isEmpty {
//            self.clearingAllLables()
//            // MARK: sender specify the particular error lable.
//            showError(message: KEY.Message.LastNameMissing, sender: lblLastName, txtField: txtLastName)
//            scrollView.setContentOffset(CGPoint(x: 0, y: (txtLastName.superview?.frame.origin.y)!), animated: true)
//            return
//        }
//        
//        if txtContactNumber.text!.count  != stringLen! {
//            if !validatePhoneNo(txtField: txtContactNumber, sender: lblContactNumber, dialCode: selectedFlag.dial_code) {
//                showError(message: KEY.Message.PhoneNoInvalid, sender: lblContactNumber, txtField: txtContactNumber)
//                return
//            }
//        }
//        if (!isMobileVerifyByphone && !isMobileVerifyByEmail) {
//            clearingAllLables()
//            showAlert(title: KEY.APPNAME.AEDLink, message: KEY.Message.pleaseVerifyPhoneOREmail)
//            return
//        }
//        // if profile image is not nil then send it first and after send remainig data.
//        if isProfilePictureUpdated {
//            // if model already containt url then first delete that image in server then send new image.
//            deleteImage { (status) in
//                if status {
//                    SendingRegisteredDataVM.shared.sendingProfilePicture(image: self.imgUserProfile.image!, headers: self.header) { (_, url) in
//                        self.updatingData(url: url)
//                    }
//                } else {
//                    showAlert(title: KEY.APPNAME.AEDLink, message: KEY.Message.SomethingWrong)
//                }
//            }
//        } else {
//            self.updatingData()
//        }
//    }
//    
//    func deleteImage(completion:@escaping (Bool) -> Void) {
//        if retriveLoginModel().data.user.profileURL != nil {
//            SendingRegisteredDataVM.shared.deletingCertificateAndProfileImage(parameter: [KEY.PARAMETER.imageLocation: retriveLoginModel().data.user.profileURL!]) { (status, _) in
//                completion(status)
//            }
//        } else {
//            SendingRegisteredDataVM.shared.sendingProfilePicture(image: self.imgUserProfile.image!, headers: self.header) { (_, url) in
//                self.updatingData(url: url)
//            }
//        }
//    }
//    
//    func clearingAllLables() {
//        clearWarningLabel(givenLable: lblFirstName, givenTextField: txtFirstName)
//        clearWarningLabel(givenLable: lblLastName, givenTextField: txtLastName)
//        clearWarningLabel(givenLable: lblContactNumber, givenTextField: txtContactNumber)
//    }
//    
//    func updatingData(url: String = KEY.BLANKSPACE.Space) {
//        let contactNumber = txtContactNumber.text!.replacingOccurrences(of: KEY.BLANKSPACE.Space, with: KEY.BLANKSPACE.blank)
//        var parameter = [KEY.PARAMETER.firstname: txtFirstName.text!, KEY.PARAMETER.lastname: txtLastName.text!, KEY.PARAMETER.email: txtEmail.text!, KEY.PARAMETER.organization: txtOrgnization.text!] as [String: Any]
//        if contactNumber.count + 1 != stringLen {
//            parameter[KEY.PARAMETER.phone] = contactNumber
//        } else {
//            parameter[KEY.PARAMETER.phone] = ""
//        }
//        var verifiedArr = [String]()
//        if isMobileVerifyByphone {
//            verifiedArr.append(KEY.PARAMETER.phone)
//        }
//        if isMobileVerifyByEmail {
//            verifiedArr.append(KEY.PARAMETER.email)
//        }
//        parameter[KEY.PARAMETER.verifiedBy] = verifiedArr
//        
//        if url != KEY.BLANKSPACE.Space {
//            parameter[KEY.PARAMETER.profileURL] = url
//        }
//        SendingRegisteredDataVM.shared.callUpdateBasicDetail(parameter: parameter, header: header) { (msg, status) in
//            if status {
//                self.navigationController?.popViewController(animated: true)
//            }
//            showAlert(title: KEY.APPNAME.AEDLink, message: msg)
//        }
//    }
//    func openCamera() {
//        if UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
//            let imag = UIImagePickerController()
//            imag.delegate = self
//            imag.sourceType = UIImagePickerController.SourceType.camera
//            imag.allowsEditing = true
//            self.present(imag, animated: true, completion: nil)
//        } else {
//            showAlert(title: KEY.APPNAME.AEDLink, message: KEY.Message.SomethingWrong)
//        }
//    }
//    func openGallary() {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
//            let imag = UIImagePickerController()
//            imag.sourceType = UIImagePickerController.SourceType.photoLibrary
//            imag.delegate = self
//            //If you dont want to edit the photo then you can set allowsEditing to false
//            imag.allowsEditing = true
//            self.present(imag, animated: true, completion: nil)
//        }
//    }
//    
//    @IBAction func btnBackTapped(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    @IBAction func btnResendTapped(_ sender: Any) {
//        // based on verification method we navigate to same function for resending OTP.
//        if userOptedEmailVerification {
//            btnSendOTPByEmailTapped(btnSendOTPByEmail!)
//        } else {
//            btnSendOTPTapped(btnSendOTP!)
//        }
//    }
//    @IBAction func verifyViewDismissedTapped(_ sender: Any) {
//        viewTransperant.isHidden = true
//        timer.invalidate()
//        txtVerifyContactNumber.isEnabled = true
//        txtVerifyEmail.isEnabled = true
//        scrollView.isScrollEnabled = true
//    }
//    
//    @IBAction func btnSendOTPByEmailTapped(_ sender: Any) {
//        if !validateEmail(txtField: txtEmail, sender: lblEmail) {
//            scrollView.setContentOffset(CGPoint(x: 0, y: (txtEmail.superview?.frame.origin.y)!), animated: true)
//            return
//        }
//        let dictOTPRequest: [String: Any] = [KEY.PARAMETER.email: txtEmail.text!]
//        checkingEmailModel.sendOTPByEmail(parameter: dictOTPRequest) { (msg,status)  in
//            if status == false {
//                showAlert(title: KEY.APPNAME.AEDLink, message: msg)
//                return
//            }
//        }
//        lblOTPViewHeading.text = KEY.Message.verifyByEmail
//        imgVerifyPhoneFlag.isHidden = true
//        userOptedEmailVerification = true
//        txtVerifyContactNumber.isHidden = true
//        txtVerifyEmail.isHidden = false
//        txtOTP1.isEnabled = true
//        txtOTP1.becomeFirstResponder()
//        seconds = 60
//        btnResendOTP.isEnabled = false
//        viewTransperant.isHidden = false
//        scrollView.isScrollEnabled = false
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
//        txtVerifyEmail.text = txtEmail.text!
//        txtVerifyEmail.isEnabled = false
//    }
//    
//    @IBAction func btnSendOTPTapped(_ sender: Any) {
//        if validatePhoneNo(txtField: txtContactNumber, sender: lblContactNumber, dialCode: selectedFlag.dial_code) {
//            let dictOTPRequest: [String: Any] = [KEY.PARAMETER.phone: txtContactNumber.text!]
//            checkingEmailModel.sendOTP(parameter: dictOTPRequest) { (msg,status)  in
//                if status == false {
//                    showAlert(title: KEY.APPNAME.AEDLink, message: msg)
//                    return
//                }
//            }
//            lblOTPViewHeading.text = KEY.Message.verifyByPhoneNumber
//            imgVerifyPhoneFlag.isHidden = false
//            userOptedEmailVerification = false
//            txtVerifyContactNumber.isHidden = false
//            txtVerifyEmail.isHidden = true
//            txtOTP1.isEnabled = true
//            txtOTP1.becomeFirstResponder()
//            seconds = 60
//            btnResendOTP.isEnabled = false
//            viewTransperant.isHidden = false
//            scrollView.isScrollEnabled = false
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
//            txtVerifyContactNumber.text = txtContactNumber.text!
//            txtVerifyContactNumber.isEnabled = false
//            imgVerifyPhoneFlag.image = countryFlag.image
//        }
//    }
//    @IBAction func btnVerifyTapped(_ sender: Any) {
//        if userOptedEmailVerification {
//            self.verifyingOTPByEmail()
//        } else {
//            self.verifyingOTP()
//        }
//    }
//    
//    func textFieldDidDelete() {
//        
//        if activeTextField == txtOTP1 {
//            print("backButton was pressed in txtOTP1")
//            // do nothing
//        }
//        
//        if activeTextField == txtOTP2 {
//            print("backButton was pressed in txtOTP2")
//            txtOTP1.isEnabled = true
//            txtOTP1.becomeFirstResponder()
//            txtOTP1.text = ""
//        }
//        
//        if activeTextField == txtOTP3 {
//            print("backButton was pressed in txtOTP3")
//            txtOTP2.isEnabled = true
//            txtOTP2.becomeFirstResponder()
//            txtOTP2.text = ""
//        }
//        
//        if activeTextField == txtOTP4 {
//            print("backButton was pressed in txtOTP4")
//            txtOTP3.isEnabled = true
//            txtOTP3.becomeFirstResponder()
//            txtOTP3.text = ""
//        }
//        
//        if activeTextField == txtOTP5 {
//            print("backButton was pressed in txtOTP4")
//            txtOTP4.isEnabled = true
//            txtOTP4.becomeFirstResponder()
//            txtOTP4.text = ""
//        }
//        if activeTextField == txtOTP6 {
//            print("backButton was pressed in txtOTP4")
//            txtOTP5.isEnabled = true
//            txtOTP5.becomeFirstResponder()
//            txtOTP5.text = ""
//        }
//    }
//}
//
//extension EditProfileViewController {
//    
//    //RESENT OTP TIMER COUNTER
//    @objc func counter() {
//        seconds -= 1
//        var fontSize = 16
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            fontSize = 20
//        }
//        lblTimerCountDown.attributedText =
//            NSMutableAttributedString()
//                .normal(KEY.Message.otpMsg, fontSize: CGFloat(fontSize), fonType: KEY.FONT.FUTURABOOK)
//                .bold(String(seconds), fontSize: CGFloat(fontSize), fonType: KEY.FONT.FUTURABOLD)
//                .normal(KEY.Message.seconds, fontSize: CGFloat(fontSize), fonType: KEY.FONT.FUTURABOOK)
//        
//        if seconds == 0 {
//            seconds = 70
//            timer.invalidate()
//            btnResendOTP.isEnabled = true
//        }
//    }
//    
//    //Update model after save data.
//    func setupTextFieldFromData() {
//        do {
//            let userDefaults = UserDefaults.standard
//            let decoded  = userDefaults.data(forKey: KEY.USERDEFAULT.LoginData)
//            let loginData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as? LoginData
//            let userData = loginData!.data.user
//            txtFirstName.text = userData?.firstname
//            txtLastName.text = userData?.lastname
//            txtEmail.text = userData?.email
//            txtOrgnization.text = userData?.organization
//            if userData?.phone != nil && userData?.phone != "" {
//                let phoneNumber =  PartialFormatter().formatPartial((userData?.phone)!)
//                let numbers = phoneNumber.components(separatedBy: KEY.BLANKSPACE.Space)
//                let phoneNoWithoutCountryCode = userData?.phone.replacingOccurrences(of: numbers[0], with: KEY.BLANKSPACE.blank)
//                txtContactNumber.text = numbers[0] + KEY.BLANKSPACE.Space + phoneNoWithoutCountryCode!
//            } else {
//                txtContactNumber.text = "+1" + KEY.BLANKSPACE.Space
//            }
//            if (userData?.verifiedBy.contains(KEY.PARAMETER.phone))! {
//                if UIDevice.current.userInterfaceIdiom == .phone {
//                    constraintThirdSeperatorTop.constant = -16
//                    self.constraintviewHeight.constant -= 70
//                } else {
//                    constraintThirdSeperatorTop.constant = -35
//                }
//                btnSendOTP.isHidden = true
//                imgVerifyPhone.isHidden = false
//                isMobileVerifyByphone = true
//               updateEmailPhoneValue[KEY.PARAMETER.phone] = txtContactNumber.text!
//            }
//            if (userData?.verifiedBy.contains(KEY.PARAMETER.email))! {
//                if UIDevice.current.userInterfaceIdiom == .phone {
//                    constraintSecondSeperatorTop.constant = -16
//                    self.constraintviewHeight.constant -= 70
//                } else {
//                    constraintSecondSeperatorTop.constant = -35
//                }
//                btnSendOTPByEmail.isHidden = true
//                isMobileVerifyByEmail = true
//                imgVerifyEmail.isHidden = false
//                updateEmailPhoneValue[KEY.PARAMETER.email] = retriveLoginModel().data.user.email!
//            }
//            authToken = loginData?.data.jwtToken
//            userId = loginData?.data.user.id
//        } catch {
//        }
//    }
//    
//    func setupFields() {
//        displayHeight = constraintviewHeight.constant
//        txtFirstName.setupTextFieldDesign()
//        txtLastName.setupTextFieldDesign()
//        txtEmail.setupTextFieldDesign()
//        btnVerify.setupBtnDesign()
//        txtContactNumber.setupTextFieldDesign()
//        imgVerifyPhone.isHidden = true
//        imgVerifyEmail.isHidden = true
//        viewTransperant.isHidden = true
//        viewOTP.layer.borderWidth = 1
//        viewOTP.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.2352941176, blue: 0.5254901961, alpha: 1)
//        viewOTP.layer.cornerRadius = 4
//        txtOTP1.myDelegate = self
//        txtOTP2.myDelegate = self
//        txtOTP3.myDelegate = self
//        txtOTP4.myDelegate = self
//        txtOTP5.myDelegate = self
//        txtOTP6.myDelegate = self
//        choosenCountryFlag = selectedFlag
//        imgUserProfile.layer.cornerRadius = imgUserProfile.frame.height/2
//        imgUserProfile.layer.borderWidth = 1
//        imgUserProfile.layer.borderColor = #colorLiteral(red: 0.007843137255, green: 0.4941176471, blue: 0.7647058824, alpha: 1)
//        imgUserProfile.layer.masksToBounds = false
//        imgUserProfile.clipsToBounds = true
//    }
//    
//    func verifyingOTP() {
//        if txtOTP1.text!.isEmpty || txtOTP2.text!.isEmpty || txtOTP3.text!.isEmpty || txtOTP4.text!.isEmpty || txtOTP5.text!.isEmpty || txtOTP6.text!.isEmpty {
//            showAlert(title: KEY.APPNAME.AEDLink, message: KEY.Message.enterOTP)
//        }
//        var OTP = txtOTP1.text! + txtOTP2.text!
//        OTP +=  txtOTP3.text! + txtOTP4.text!
//        OTP +=  txtOTP5.text! + txtOTP6.text!
//        let parameter = ["otp": OTP, "phone": txtContactNumber.text!]
//        VerifyOTPVM.shared.verifyOTP(parameter: parameter) { (status, msg) in
//            if !status {
//                showAlert(title: KEY.APPNAME.AEDLink, message: msg)
//            } else {
//                self.btnSendOTP.isHidden = true
//                self.viewTransperant.isHidden = true
//                self.imgVerifyPhone.isHidden = false
//                self.isMobileVerifyByphone = true
//                self.scrollView.isScrollEnabled = true
//                self.updateEmailPhoneValue[KEY.PARAMETER.phone] = self.txtVerifyContactNumber.text!
//                clearWarningLabel(givenLable: self.lblContactNumber, givenTextField: self.txtContactNumber)
//                if UIDevice.current.userInterfaceIdiom == .phone {
//                    self.constraintviewHeight.constant -= 70
//                    self.constraintThirdSeperatorTop.constant = -16
//                } else {
//                    self.constraintviewHeight.constant -= 120
//                    self.constraintThirdSeperatorTop.constant = -24
//                }
//                
//            }
//        }
//    }
//    
//    func verifyingOTPByEmail() {
//        if txtOTP1.text!.isEmpty || txtOTP2.text!.isEmpty || txtOTP3.text!.isEmpty || txtOTP4.text!.isEmpty || txtOTP5.text!.isEmpty || txtOTP6.text!.isEmpty {
//            showAlert(title: KEY.APPNAME.AEDLink, message: KEY.Message.enterOTP)
//        }
//        var OTP = txtOTP1.text! + txtOTP2.text!
//        OTP +=  txtOTP3.text! + txtOTP4.text!
//        OTP +=  txtOTP5.text! + txtOTP6.text!
//        let parameter = ["otp": OTP, "email": txtEmail.text!]
//        VerifyOTPVM.shared.verifyOTPByEmail(parameter: parameter) { (status, msg) in
//            if !status {
//                showAlert(title: KEY.APPNAME.AEDLink, message: msg)
//            } else {
//                self.btnSendOTPByEmail.isHidden = true
//                self.viewTransperant.isHidden = true
//                self.imgVerifyEmail.isHidden = false
//                self.isMobileVerifyByEmail = true
//                self.scrollView.isScrollEnabled = true
//                self.updateEmailPhoneValue[KEY.PARAMETER.email] = self.txtVerifyEmail.text!
//                clearWarningLabel(givenLable: self.lblEmail, givenTextField: self.txtEmail)
//                if UIDevice.current.userInterfaceIdiom == .phone {
//                    self.constraintviewHeight.constant -= 70
//                    self.constraintSecondSeperatorTop.constant = -16
//                } else {
//                    self.constraintviewHeight.constant -= 120
//                    self.constraintSecondSeperatorTop.constant = -24
//                }
//                
//            }
//        }
//    }
//}
//
//extension EditProfileViewController: UITextFieldDelegate {
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField != txtOTP1 && textField != txtOTP2 && textField != txtOTP3 && textField != txtOTP4 && textField != txtOTP5 && textField != txtOTP6 {
//            textField.layer.borderWidth = 1
//            textField.layer.cornerRadius = 4
//            textField.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.2352941176, blue: 0.5254901961, alpha: 1)
//            textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
//        if textField == txtOTP1 || textField == txtOTP2 || textField == txtOTP3 || textField == txtOTP4 || textField == txtOTP5 || textField == txtOTP6 {
//            activeTextField = textField
//        }
//    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // here we compare email's entered value with old one that is stored in updateEmailPhoneValue dictionary and based on that shows verified symbol and update the value for variables
//        if textField == txtEmail {
//            let currentString: NSString = textField.text! as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            if newString as String == self.updateEmailPhoneValue[KEY.PARAMETER.email]! && self.updateEmailPhoneValue[KEY.PARAMETER.email]! != KEY.BLANKSPACE.Space {
//                imgVerifyEmail.isHidden = false
//                btnSendOTPByEmail.isHidden = true
//                if UIDevice.current.userInterfaceIdiom == .phone {
//                    constraintSecondSeperatorTop.constant = -10
//                    self.constraintviewHeight.constant -= 70
//                } else {
//                    constraintSecondSeperatorTop.constant = -35
//                }
//                isMobileVerifyByEmail = true
//            } else {
//                imgVerifyEmail.isHidden = true
//                isMobileVerifyByEmail = false
//                btnSendOTPByEmail.isHidden = false
//                if constraintviewHeight.constant < 990 {
//                    constraintviewHeight.constant += 70
//                }
//                if UIDevice.current.userInterfaceIdiom == .phone {
//                    constraintSecondSeperatorTop.constant = 30
//                } else {
//                    constraintSecondSeperatorTop.constant = 30
//                }
//            }
//        }
//        
//        // if txtContactNumber contain countrycode + space then we wouldn't allow to backspace.
//        if textField == txtContactNumber {
//            let maxLength = stringLen! + 10
//            let currentString: NSString = textField.text! as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            if newString.length < maxLength {
//                if textField.text == choosenCountryFlag.dial_code + KEY.BLANKSPACE.Space {
//                    if let char = string.cString(using: String.Encoding.utf8) {
//                        let isBackSpace = strcmp(char, "\\b")
//                        if isBackSpace == -92 {
//                            return false
//                        } else {
//                            return true
//                        }
//                    }
//                    return false
//                }
//            }
//            // here we compare phones's entered value with old one that is stored in updateEmailPhoneValue dictionary and based on that shows verified symbol and update the value for variables
//            if newString.length <= maxLength && self.updateEmailPhoneValue[KEY.PARAMETER.phone]! != KEY.BLANKSPACE.Space {
//                if newString.length <= maxLength - 1 {
//                    btnSendOTP.isHidden = false
//                    imgVerifyPhone.isHidden = true
//                    isMobileVerifyByphone = false
//                     if constraintviewHeight.constant < 990 {
//                            constraintviewHeight.constant += 70
//                    }
//                    if UIDevice.current.userInterfaceIdiom == .phone {
//                        constraintThirdSeperatorTop.constant = 30
//                    } else {
//                        constraintThirdSeperatorTop.constant = 30
//                    }
//                } else if newString as String == self.updateEmailPhoneValue[KEY.PARAMETER.phone]! {
//                    btnSendOTP.isHidden = true
//                    isMobileVerifyByphone = true
//                    imgVerifyPhone.isHidden = false
//                    if UIDevice.current.userInterfaceIdiom == .phone {
//                        constraintThirdSeperatorTop.constant = -16
//                        self.constraintviewHeight.constant -= 70
//                    } else {
//                        constraintThirdSeperatorTop.constant = -35
//                    }
//                } else {
//                    if textField.text! != self.updateEmailPhoneValue[KEY.PARAMETER.phone]! {
//                        btnSendOTP.isHidden = false
//                        imgVerifyPhone.isHidden = true
//                        isMobileVerifyByphone = false
//                        if constraintviewHeight.constant < 990 {
//                            constraintviewHeight.constant += 70
//                        }
//                        if UIDevice.current.userInterfaceIdiom == .phone {
//                            constraintThirdSeperatorTop.constant = 30
//                        } else {
//                            constraintThirdSeperatorTop.constant = 30
//                        }
//                    }
//                }
//            }
//            return newString.length <= maxLength
//        }
//        
//        // handling OTP TextFields
//        if textField == txtOTP1 || textField == txtOTP2 || textField == txtOTP3 || textField == txtOTP4 || textField == txtOTP5 || textField == txtOTP6 {
//            if let text = textField.text {
//                // when the user enters something in the first textField it will automatically adjust to the next textField and in the process do some disabling and enabling. This will proceed until the last textField
//                if (text.count < 1) && (string.count > 0) {
//                    
//                    if textField == txtOTP1 {
//                        txtOTP2.isEnabled = true
//                        txtOTP2.becomeFirstResponder()
//                    }
//                    
//                    if textField == txtOTP2 {
//                        txtOTP3.isEnabled = true
//                        txtOTP3.becomeFirstResponder()
//                    }
//                    
//                    if textField == txtOTP3 {
//                        txtOTP4.isEnabled = true
//                        txtOTP4.becomeFirstResponder()
//                    }
//                    if textField == txtOTP4 {
//                        txtOTP5.isEnabled = true
//                        txtOTP5.becomeFirstResponder()
//                    }
//                    if textField == txtOTP5 {
//                        txtOTP6.isEnabled = true
//                        txtOTP6.becomeFirstResponder()
//                    }
//                    
//                    if textField == txtOTP6 {
//                        // do nothing or better yet do something now that you have all four digits for the sms code. Once the user lands on this textField then the sms code is complete
//                    }
//                    
//                    textField.text = string
//                    return false
//                    
//                } // 11. if the user gets to the last textField and presses the back button everything above will get reversed
//                else if (text.count >= 1) && (string.count == 0) {
//                    
//                    if textField == txtOTP2 {
//                        txtOTP1.isEnabled = true
//                        txtOTP1.becomeFirstResponder()
//                        txtOTP1.text = ""
//                    }
//                    
//                    if textField == txtOTP3 {
//                        txtOTP2.isEnabled = true
//                        txtOTP2.becomeFirstResponder()
//                        txtOTP2.text = ""
//                    }
//                    
//                    if textField == txtOTP4 {
//                        txtOTP3.isEnabled = true
//                        txtOTP3.becomeFirstResponder()
//                        txtOTP3.text = ""
//                    }
//                    if textField == txtOTP5 {
//                        txtOTP4.isEnabled = true
//                        txtOTP4.becomeFirstResponder()
//                        txtOTP4.text = ""
//                    }
//                    if textField == txtOTP6 {
//                        txtOTP5.isEnabled = true
//                        txtOTP5.becomeFirstResponder()
//                        txtOTP5.text = ""
//                    }
//                    
//                    if textField == txtOTP6 {
//                        // do nothing
//                    }
//                    textField.text = ""
//                    return false
//                }
//                    //after pressing the backButton and moving forward again you will have to do what's in step 10 all over again
//                else if text.count >= 1 {
//                    
//                    if textField == txtOTP1 {
//                        txtOTP2.isEnabled = true
//                        txtOTP2.becomeFirstResponder()
//                    }
//                    
//                    if textField == txtOTP2 {
//                        txtOTP3.isEnabled = true
//                        txtOTP3.becomeFirstResponder()
//                    }
//                    
//                    if textField == txtOTP3 {
//                        txtOTP4.isEnabled = true
//                        txtOTP4.becomeFirstResponder()
//                    }
//                    if textField == txtOTP4 {
//                        txtOTP5.isEnabled = true
//                        txtOTP5.becomeFirstResponder()
//                    }
//                    if textField == txtOTP5 {
//                        txtOTP6.isEnabled = true
//                        txtOTP6.becomeFirstResponder()
//                    }
//                    
//                    if textField == txtOTP6 {
//                        // do nothing or better yet do something now that you have all four digits for the sms code. Once the user lands on this textField then the sms code is complete
//                    }
//                    
//                    textField.text = string
//                    return false
//                }
//            }
//            
//        }
//        return true
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField != txtOTP1 && textField != txtOTP2 && textField != txtOTP3 && textField != txtOTP4 && textField != txtOTP5 && textField != txtOTP6 {
//            textField.layer.borderWidth = 0
//            textField.backgroundColor = #colorLiteral(red: 0.9490197078, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
//        }
//        
//        if textField != txtOTP1 && textField != txtOTP2 && textField != txtOTP3 && textField != txtOTP4 && textField != txtOTP5 && textField != txtOTP6 {
//            textField.layer.borderWidth = 0
//            textField.backgroundColor = #colorLiteral(red: 0.9490197078, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
//        }
//        
//        if txtFirstName == textField {
//            if !txtFirstName.text!.isEmpty {
//                clearWarningLabel(givenLable: lblFirstName, givenTextField: txtFirstName)
//            }
//            return
//        }
//        if txtLastName == textField {
//            if !txtLastName.text!.isEmpty {
//                clearWarningLabel(givenLable: lblLastName, givenTextField: txtLastName)
//            }
//            return
//        }
//        if txtEmail == textField {
//            if validateEmail(txtField: txtEmail, sender: lblEmail) {
//                clearWarningLabel(givenLable: lblEmail, givenTextField: txtEmail)
//                return
//            }
//        }
//        if textField == txtContactNumber {
//            if textField.text! == retriveLoginModel().data.user.phone {
//                imgVerifyPhone.isHidden = false
//                btnSendOTP.isHidden = true
//            }
//        }
//    }
//}
