//
//  DailyQuestionnerViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 6/18/21.
//

import UIKit
import ChatSDK
class DailyQuestionnerViewController: UIViewController {
    var mood = String()
    @IBOutlet weak var heightSlider: GradientSlider!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    @IBOutlet weak var btnSubmit: UserDefineBtn!
    @IBOutlet weak var txtAns6: PaddedTextField!
    @IBOutlet weak var txtAns5: PaddedTextField!
    @IBOutlet weak var txtAns4: PaddedTextField!
    @IBOutlet weak var txtAns3: PaddedTextField!
    @IBOutlet weak var txtAns2: PaddedTextField!
    @IBOutlet weak var lblShowMood: UILabel!
    private var lastContentOffset: CGFloat = 0
    var questionnerAns = [Int:[Int]]()
    var number = 0
    var imageView : UIImageView!
    var datasource2 = [String]()
    var picker2  = UIPickerView()
    var datasource3 = [String]()
    var picker3  = UIPickerView()
    var datasource4 = [String]()
    var picker4  = UIPickerView()
    var datasource5 = [String]()
    var picker5  = UIPickerView()
    var datasource6 = [String]()
    var picker6  = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        picker2.delegate = self
        picker2.dataSource = self
        picker3.delegate = self
        picker3.dataSource = self
        picker4.delegate = self
        picker4.dataSource = self
        picker5.delegate = self
        picker5.dataSource = self
        picker6.delegate = self
        picker6.dataSource = self
        txtAns2.delegate = self
        txtAns3.delegate = self
        txtAns4.delegate = self
        txtAns5.delegate = self
        txtAns6.delegate = self
        txtAns2.layer.cornerRadius = 4
        txtAns3.layer.cornerRadius = 4
        txtAns4.layer.cornerRadius = 4
        txtAns5.layer.cornerRadius = 4
        txtAns6.layer.cornerRadius = 4
        scrollView.delegate = self
        changeBackground(view: baseView)
        changeBackground(view: view)
        setThumbImage(image: "😃".image()!)
        datasource2 = ["Always", "Often", "Sometimes", "Rarely", "Never"]
        datasource3 = ["Always", "Often", "Sometimes", "Rarely", "Never"]
        datasource4 = ["Always", "Often", "Sometimes", "Rarely", "Never"]
        datasource5 = ["Always", "Often", "Sometimes", "Rarely", "Never"]
        datasource6 = [KEY.MESSAGE.took_all_medication, KEY.MESSAGE.did_not_take_medication,KEY.MESSAGE.some_medication]
    }
    
    func setThumbImage(image: UIImage){
        heightSlider.setThumbImage(image, for: .normal)
        heightSlider.setThumbImage(image, for: .highlighted)
    }
    //datasource = ["Happy", "Motivated", "Calm", "Blah", "Sad", "Stressed", "Angry"]
    @IBAction func changeSliderValue(_ sender: Any) {
        if heightSlider.value > 0 && heightSlider.value < 0.142857 {
            setThumbImage(image: "😃".image()!)
            mood = "HAPPPY"
            lblShowMood.text = "HAPPPY"
        } else if heightSlider.value > 0.142857 && heightSlider.value < 0.285714 {
            setThumbImage(image: "💪".image()!)
            mood = "MOTIVATED"
            lblShowMood.text = "MOTIVATED"
        } else if heightSlider.value > 0.285714 && heightSlider.value < 0.428571 {
            setThumbImage(image: "😌".image()!)
            mood = "CALM"
            lblShowMood.text = "CALM"
        } else if heightSlider.value > 0.428571 && heightSlider.value < 0.571428 {
            setThumbImage(image: "😐".image()!)
            mood = "BLAH"
            lblShowMood.text = "BLAH"
        } else if heightSlider.value > 0.571428 && heightSlider.value < 0.714285 {
            setThumbImage(image: "🙁".image()!)
            mood = "SAD"
            lblShowMood.text = "SAD"
        } else if heightSlider.value > 0.714285 && heightSlider.value < 0.857142 {
            setThumbImage(image: "😰".image()!)
            mood = "STRESSED"
            lblShowMood.text =  "STRESSED"
        } else if heightSlider.value > 0.857142 {
            setThumbImage(image: "😡".image()!)
            mood = "ANGRY"
            lblShowMood.text = "ANGRY"
        } else if heightSlider.value == 0.0 {
            setThumbImage(image: "😡".image()!)
            mood = "ANGRY"
            lblShowMood.text = "Please use slider for indicate your mood."
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        scrollView.backgroundColor = .clear
        baseView.isHidden = true
        NavigationHeaderView.updateView(view: viewNavigation)
        UserDefineBtn.updateView(view: btnSubmit)
        changeBackground(view: baseView)
        changeBackground(view: view)
        lblShowMood.text = "Please use slider for indicate your mood."
        //            self.clearTextField(textField: self.txtAns1)
        self.clearTextField(textField: self.txtAns2)
        self.clearTextField(textField: self.txtAns3)
        self.clearTextField(textField: self.txtAns4)
        self.clearTextField(textField: self.txtAns5)
        self.clearTextField(textField: self.txtAns6)
        assignbackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [self] in
            self.imageView.isHidden = true
            self.baseView.isHidden = false
            checkTodayDataIsAvailable()
        }
    }
    
    func assignbackground(){
        do {
            let imageData = try Data(contentsOf: Bundle.main.url(forResource: "8600-check-list", withExtension: "gif")!)
            let background =  UIImage.gif(data: imageData)!
            imageView = UIImageView(frame: view.bounds)
            imageView.contentMode =  UIView.ContentMode.scaleAspectFit
            imageView.clipsToBounds = true
            imageView.image = background
            view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width-50).isActive = true
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
            view.sendSubviewToBack(imageView)
        } catch {
            print(error)
        }
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }
    @objc func textFieldDidChangeAns(_ textField: UITextField) {
        //        if textField == txtAns1 {
        //            datasource = ["Happy", "Motivated", "Calm", "Blah", "Sad", "Stressed", "Angry"]
        //            setupPicker(textField: textField)
        //        } else
     
    }
    
    func checkTodayDataIsAvailable() {
        let date = String(removeTimeStamp(fromDate: Date()).millisecondsSince1970)
        if NetworkReachabilityManager()!.isReachable {
            
            let docRef = db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("dailyCheckIn").document(date)
            docRef.getDocument { [self] (document, error) in
                if document!.exists {
                    showAlert(title: KEY.PARAMETER.DailyCheckIn, message: KEY.MESSAGE.already_submitted)
                    txtAns6.isUserInteractionEnabled = false
                    txtAns5.isUserInteractionEnabled = false
                    txtAns4.isUserInteractionEnabled = false
                    txtAns3.isUserInteractionEnabled = false
                    txtAns2.isUserInteractionEnabled = false
                    heightSlider.isUserInteractionEnabled = false
                    btnSubmit.isUserInteractionEnabled = false
                }
            }
        } else {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
        }
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        if txtAns2.text!.isEmpty || txtAns3.text!.isEmpty || txtAns4.text!.isEmpty || txtAns5.text!.isEmpty || txtAns6.text!.isEmpty{
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.fill_all_answer)
        }
        else {
            questionnerAns.removeAll()
            if heightSlider.value > 0.428571 {
                if questionnerAns[1] != nil {
                    questionnerAns[1]!.append(1)
                } else {
                    questionnerAns[1] = [1]
                }
                if questionnerAns[8] != nil {
                    questionnerAns[8]!.append(1)
                } else {
                    questionnerAns[8] = [1]
                }
                if questionnerAns[4] != nil {
                    questionnerAns[4]!.append(1)
                } else {
                    questionnerAns[4] = [1]
                }
                if questionnerAns[3] != nil {
                    questionnerAns[3]!.append(1)
                } else {
                    questionnerAns[3] = [1]
                }
            }
            if txtAns2.text == "Sometimes" || txtAns2.text == "Often" || txtAns2.text == "Always"{
                    if questionnerAns[1] != nil {
                        questionnerAns[1]!.append(2)
                    } else {
                        questionnerAns[1] = [2]
                    }
                    if questionnerAns[8] != nil {
                        questionnerAns[8]!.append(2)
                    } else {
                        questionnerAns[8] = [2]
                    }
                    if questionnerAns[4] != nil {
                        questionnerAns[4]!.append(2)
                    } else {
                        questionnerAns[4] = [2]
                    }
                    if questionnerAns[3] != nil {
                        questionnerAns[3]!.append(2)
                    } else {
                        questionnerAns[3] = [2]
                    }
            }
                
            if txtAns3.text == "Sometimes" || txtAns3.text == "Rarely" || txtAns3.text == "Never"{
                if questionnerAns[7] != nil {
                    questionnerAns[7]!.append(3)
                } else {
                    questionnerAns[7] = [3]
                }
                if questionnerAns[1] != nil {
                    questionnerAns[1]!.append(3)
                } else {
                    questionnerAns[1] = [3]
                }
            }
            if txtAns4.text == "Sometimes" || txtAns4.text == "Rarely" || txtAns4.text == "Never"{
                if questionnerAns[5] != nil {
                    questionnerAns[5]!.append(4)
                } else {
                    questionnerAns[5] = [4]
                }
                if questionnerAns[8] != nil {
                    questionnerAns[8]!.append(4)
                } else {
                    questionnerAns[8] = [4]
                }
                if questionnerAns[9] != nil {
                    questionnerAns[9]!.append(4)
                } else {
                    questionnerAns[9] = [4]
                }
            }
            if txtAns5.text == "Sometimes" || txtAns5.text == "Rarely" || txtAns5.text == "Never"{
                if questionnerAns[1] != nil {
                    questionnerAns[1]!.append(5)
                } else {
                    questionnerAns[1] = [5]
                }
                if questionnerAns[5] != nil {
                    questionnerAns[5]!.append(5)
                } else {
                    questionnerAns[5] = [5]
                }
                if questionnerAns[4] != nil {
                    questionnerAns[4]!.append(5)
                } else {
                    questionnerAns[4] = [5]
                }
            }
            if txtAns6.text == KEY.MESSAGE.did_not_take_medication{
                if questionnerAns[10] != nil {
                    questionnerAns[10]!.append(6)
                } else {
                    questionnerAns[10] = [6]
                }
            }
            storeQueAnsArr(arr: questionnerAns)
            let accept = {
                self.tabBarController!.selectedIndex = 3
                self.storeDataInDB()
            }
            
            let reject = { [self] in
                //  self.clearTextField(textField: self.txtAns1)
                self.storeDataInDB()
                setThumbImage(image: "😃".image()!)
                heightSlider.value = 0
//                self.clearTextField(textField: self.txtAns2)
//                self.clearTextField(textField: self.txtAns3)
//                self.clearTextField(textField: self.txtAns4)
//                self.clearTextField(textField: self.txtAns5)
//                self.clearTextField(textField: self.txtAns6)
            }
            var message = KEY.MESSAGE.fill_all_answer
            if questionnerAns[10] != nil {
                let reject1 = {
                    message = KEY.MESSAGE.visit_mindfulness
                    showAlertWithActions(title: KEY.PARAMETER.Mindfulness, secBtnTitle: KEY.BTN_NAME.visit, message: message, accept: accept, reject: reject)
                }
                showAlertWithSingleAction(title: KEY.PARAMETER.Medication, message: KEY.MESSAGE.important_medicines,reject: reject1)
                
                
            } else {
                message = KEY.MESSAGE.visit_mindfulness
            }
            showAlertWithActions(title: KEY.PARAMETER.Mindfulness, secBtnTitle: KEY.BTN_NAME.visit, message: message, accept: accept, reject: reject)
        }
    }
    
    func storeDataInDB() {
        let date = String(removeTimeStamp(fromDate: Date()).millisecondsSince1970)
        if NetworkReachabilityManager()!.isReachable {
            db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("dailyCheckIn").document(date).setData(["date":Int(date),"question1":mood, "question2":txtAns2.text!, "question3":txtAns3.text!, "question4":txtAns4.text!, "question5":txtAns5.text!, "question6":txtAns6.text!])
            
            let docRef = db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("dailyCheckIn").document(date)
            docRef.getDocument { [self] (document, error) in
                if document!.exists {
                    db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("dailyCheckIn").document(date).updateData(["date":Int(date),"question1":mood, "question2":txtAns2.text!, "question3":txtAns3.text!, "question4":txtAns4.text!, "question5":txtAns5.text!, "question6":txtAns6.text!])
                } else {
                    db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("dailyCheckIn").document(date).setData(["date":Int(date),"question1":mood, "question2":txtAns2.text!, "question3":txtAns3.text!, "question4":txtAns4.text!, "question5":txtAns5.text!, "question6":txtAns6.text!])
                }
            }
        } else {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
        }
    }
    
    func clearTextField(textField: UITextField){
        textField.text = ""
    }
    
    
    func setupPickerTxt6(textField: UITextField) {
        var toolBar = UIToolbar()
        toolBar.sizeToFit()
        picker6.backgroundColor = UIColor.white
        picker6.setValue(UIColor.black, forKey: "textColor")
        picker6.autoresizingMask = .flexibleWidth
        picker6.selectRow(0, inComponent:0, animated:true)
        picker6.contentMode = .center
        picker6.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubview(picker6)
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTappedTxt6))]
        txtAns6.inputView = picker6
        txtAns6.inputAccessoryView = toolBar

        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTappedTxt6() {
        if txtAns6.text == ""{
            pickerView(picker6, didSelectRow: 0, inComponent: 0)
        }
        if txtAns6.text == KEY.MESSAGE.took_all_medication {
            picker6.selectRow(0, inComponent: 0, animated: true)
        }
        self.view.endEditing(true)
    }
    
    func setupPickerTxt5(textField: UITextField) {
        var toolBar = UIToolbar()
        toolBar.sizeToFit()
        picker5.backgroundColor = UIColor.white
        picker5.setValue(UIColor.black, forKey: "textColor")
        picker5.autoresizingMask = .flexibleWidth
        picker5.selectRow(0, inComponent:0, animated:true)
        picker5.contentMode = .center
        picker5.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubview(picker5)
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTappedTxt5))]
        txtAns5.inputView = picker5
        txtAns5.inputAccessoryView = toolBar
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTappedTxt5() {
        if txtAns5.text == ""{
            pickerView(picker5, didSelectRow: 0, inComponent: 0)
        }
        if txtAns5.text == "Always"{
            picker5.selectRow(0, inComponent: 0, animated: true)
        }
        self.view.endEditing(true)
    }
    
    func setupPickerTxt4(textField: UITextField) {
        var toolBar = UIToolbar()
        toolBar.sizeToFit()
        picker4.backgroundColor = UIColor.white
        picker4.setValue(UIColor.black, forKey: "textColor")
        picker4.autoresizingMask = .flexibleWidth
        picker4.selectRow(0, inComponent:0, animated:true)
        picker4.contentMode = .center
        picker4.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubview(picker4)
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTappedTxt4))]
        txtAns4.inputView = picker4
        txtAns4.inputAccessoryView = toolBar
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTappedTxt4() {
        if txtAns4.text == ""{
            pickerView(picker4, didSelectRow: 0, inComponent: 0)
        }
        if txtAns4.text == "Always"   {
            picker4.selectRow(0, inComponent: 0, animated: true)
        }
        self.view.endEditing(true)
    }
    
    func setupPickerTxt2(textField: UITextField) {
        var toolBar = UIToolbar()
        toolBar.sizeToFit()
        picker2.backgroundColor = UIColor.white
        picker2.setValue(UIColor.black, forKey: "textColor")
        picker2.autoresizingMask = .flexibleWidth
        picker2.selectRow(0, inComponent:0, animated:true)
        picker2.contentMode = .center
        picker2.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubview(picker2)
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTappedTxt2))]
        txtAns2.inputView = picker2
        txtAns2.inputAccessoryView = toolBar
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTappedTxt2() {
        if txtAns2.text == ""{
            pickerView(picker2, didSelectRow: 0, inComponent: 0)
        }
        if txtAns2.text == "Always"  {
            picker2.selectRow(0, inComponent: 0, animated: true)
        }
        self.view.endEditing(true)
    }
    
    func setupPickerTxt3(textField: UITextField) {
        var toolBar = UIToolbar()
        toolBar.sizeToFit()
        picker3.backgroundColor = UIColor.white
        picker3.setValue(UIColor.black, forKey: "textColor")
        picker3.autoresizingMask = .flexibleWidth
        picker3.selectRow(0, inComponent:0, animated:true)
        picker3.contentMode = .center
        picker3.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubview(picker3)
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTappedTxt3))]
        txtAns3.inputView = picker3
        txtAns3.inputAccessoryView = toolBar
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTappedTxt3() {
        if txtAns3.text == ""{
            pickerView(picker3, didSelectRow: 0, inComponent: 0)
        }
        if  txtAns3.text == "Always"  {
            picker3.selectRow(0, inComponent: 0, animated: true)
        }
        self.view.endEditing(true)
    }
    
    
    public func showAlertWithSingleAction(title: String, message: String, reject: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { sender in
            reject?()
        }))
        self.present(alert, animated: true, completion: completion)
    }
    
}
extension DailyQuestionnerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if number == 2 {
            return datasource2.count
        } else if number == 3 {
            return datasource3.count
        } else if number == 4 {
            return datasource4.count
        } else if number == 5 {
            return datasource5.count
        } else {
            return datasource6.count
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if number == 2 {
            return datasource2[row]
        } else if number == 3 {
            return datasource3[row]
        } else if number == 4 {
            return datasource4[row]
        } else if number == 5 {
            return datasource5[row]
        } else  {
            return  datasource6[row]
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if number == 2 {
            txtAns2.text =  datasource2[row]
        } else if number == 3 {
            txtAns3.text =  datasource3[row]
        } else if number == 4 {
            txtAns4.text =  datasource4[row]
        } else if number == 5 {
            txtAns5.text =  datasource5[row]
        } else if number == 6 {
            txtAns6.text =  datasource6[row]
        }
    }
}


extension DailyQuestionnerViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.2352941176, blue: 0.5254901961, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if textField == txtAns2 {
            number = 2
            setupPickerTxt2(textField: textField)
        } else if textField == txtAns3 {
            number = 3
            setupPickerTxt3(textField: textField)
        }
        else if textField == txtAns4 {
            number = 4
            setupPickerTxt4(textField: textField)
        }
        else if textField == txtAns5 {
            number = 5
            setupPickerTxt5(textField: textField)
        }
        else if textField == txtAns6 {
            number = 6
            setupPickerTxt6(textField: textField)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        textField.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.9882352941, alpha: 0.4155214271)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension DailyQuestionnerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }
}
