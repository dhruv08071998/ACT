//
//  ConfirmAptViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 8/3/21.
//

import UIKit
import FSCalendar
import IQKeyboardManagerSwift
import UserNotifications
class ConfirmAptViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtSelectAppointmentType: PaddedTextField!
    @IBOutlet weak var Confirm: UserDefineBtn!
    @IBOutlet weak var txtViewNotes: UITextView!
    @IBOutlet weak var txtDate: PaddedTextField!
    @IBOutlet weak var calender: FSCalendar!
    var temp = 0
    var datasource = [String]()
    var picker  = UIPickerView()
    let center = UNUserNotificationCenter.current()
    
    let datePicker = UIDatePicker()
    var placeholderLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calender.delegate = self
        calender.dataSource = self
        picker.delegate = self
        picker.dataSource = self
        txtDate.addTarget(self, action: #selector(ReminderSetViewController.textFieldDidChangeDate(_:)),
                          for: .editingDidBegin)
        txtViewNotes.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = KEY.PARAMETER.notes
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (txtViewNotes.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        txtViewNotes.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (txtViewNotes.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !txtViewNotes.text.isEmpty
        datasource = [KEY.PARAMETER.clinic, KEY.PARAMETER.message, KEY.PARAMETER.call]
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        modifiedApt = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if modifiedApt != nil {
            txtDate.text = modifiedApt?.time!
            txtViewNotes.text = modifiedApt?.notes!
            placeholderLabel.isHidden = !txtViewNotes.text.isEmpty
            txtSelectAppointmentType.text = modifiedApt?.appointmentType!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = KEY.DATEFORMAT.MM_dd_yy
            let date = dateFormatter.date(from: (modifiedApt?.date as? String)!) ?? Date()
            calender.select(date)
        }
    }
    
    @objc func textFieldDidChangeDate(_ textField: PaddedTextField) {
        datePicker.datePickerMode = .time
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        if calender.selectedDate == Date().stripTime() || calender.selectedDate == nil {
            datePicker.minimumDate = Date()
        } else {
            datePicker.minimumDate = nil
        }
        let doneButton = UIBarButtonItem(title: KEY.PARAMETER.done, style: .plain, target: self, action: #selector(donedatePickerFirstDose))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: KEY.PARAMETER.cancel, style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    @objc func donedatePickerFirstDose(_ sender:UITextField) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let time = formatter.string(from: datePicker.date)
        txtDate.text = time
        //arr.append(time)
        self.view.endEditing(true)
        txtDate.isUserInteractionEnabled = true
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    
    @IBAction func btnConfirmTapped(_ sender: Any) {
        if (txtDate.text!.isEmpty) {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: "Please select a time")
            return
        }
        if (txtSelectAppointmentType.text!.isEmpty)  {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: "Please select an appointment type")
            return
        }
        let obj = Appointment()
        if modifiedApt != nil {
            obj.patientName = modifiedApt?.patientName!
            deleteIfUpdateHappens()
        } else {
            obj.patientName = tempPatientData?.name()!
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.MM_dd_yyyy
        if calender.selectedDate != nil{
            obj.date =  dateFormatter.string(from: calender.selectedDate!)
            obj.timeAndDate = getDateFormat(date: (calender.selectedDate?.stripTime().dateToString())!, time: txtDate.text!)
        } else {
            obj.date = dateFormatter.string(from: Date())
            obj.timeAndDate = getDateFormat(date: Date().stripTime().dateToString() , time: txtDate.text!)
        }
        obj.notes = txtViewNotes.text!
        obj.time = txtDate.text!
        obj.appointmentType = txtSelectAppointmentType.text!
        var newApp = [Appointment]()
        if modifiedApt != nil {
            for app in appointments{
                if compareObjs(obj1: app, obj2: modifiedApt!) {
                    newApp.append(obj)
                } else {
                    newApp.append(app)
                }
            }
            appointments = newApp
            storeAptArr(arr: appointments)
        } else {
            appointments.append(obj)
            storeAptArr(arr: appointments)
        }
        processReminder(mdate: obj.timeAndDate, patientName: obj.patientName)
        self.dismiss(animated: true, completion: nil)
        modifiedApt = nil
    }
    
    func processReminder(mdate: Date, patientName: String) {
        if mdate.millisecondsSince1970 > Date().millisecondsSince1970 {
            let date = Date(milliseconds: mdate.millisecondsSince1970 - (5*60*1000))
            if date.millisecondsSince1970 > Date().millisecondsSince1970 {
                addTask(givenDate: date, message: KEY.MESSAGE.aptReminder + patientName + KEY.MESSAGE.in_minutes)
            }
        }
        
    }
    
    func compareObjs(obj1: Appointment, obj2: Appointment) -> Bool{
        if obj1.patientName == obj2.patientName && obj1.date == obj2.date && obj1.time == obj2.time && obj1.notes == obj2.notes && obj1.timeAndDate == obj2.timeAndDate {
            return true
        } else {
            return false
        }
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
        if txtSelectAppointmentType.text == ""{
            pickerView(picker, didSelectRow: 0, inComponent: 0)
        }
        self.view.endEditing(true)
    }
    
    func addTask(givenDate: Date, message: String) {
        var task: Task
        task = Task(context: context)
        let dateFormatters = DateFormatter()
        dateFormatters.dateFormat = KEY.DATEFORMAT.YY_MMM_D_HH_mm
        task.name = message + dateFormatters.string(from: givenDate)
        let time = givenDate
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.hh_mm_a
        var dateString = dateFormatter.string(from: date)
        var alertTitle: String
        var alertMessage: String
        print("--- Starting Time Prep--- ")
        print("Now: " + dateString)
        alertTitle = "Now: "+dateString
        dateString = dateFormatter.string(from: time)
        print("Chosen: " + dateString)
        alertMessage = "Chosen: "+dateString+"\n"
        
        let timeInterval = time.timeIntervalSinceNow
        let str = NSString(format:"Interval: %.0fh %.0fm %.0fs", (timeInterval/3600).rounded(.towardZero), (timeInterval/60).truncatingRemainder(dividingBy: 60), timeInterval.truncatingRemainder(dividingBy: 60))
        print(str)
        alertMessage = alertMessage + (str as String)
        
        task.notificationTime = time
        
        task.shouldAct = false
        
        //Save the data to Core Data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Convert Date to String
        scheduleNotification(taskName: message, taskDate: givenDate,inSeconds: timeInterval, completion: {success in
            if success{
                print(timeInterval)
            } else {
                
            }
        })
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    }
    
    func scheduleNotification(taskName: String, taskDate: Date,inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { po in
            print(po)
        }
        let notif = UNMutableNotificationContent()
        notif.title = KEY.PARAMETER.Reminder
        notif.body = taskName
        notif.sound = UNNotificationSound.default
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.YY_MMM_D_HH_mm
        let request = UNNotificationRequest(identifier: dateFormatter.string(from: taskDate), content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        })
        
    }
    
    func deleteIfUpdateHappens() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.YY_MMM_D_HH_mm
        // let deleteDate = dateFormatter.string(from: (modifiedApt?.timeAndDate)!)
        let deleteDate = dateFormatter.string(from: Date(milliseconds: (modifiedApt?.timeAndDate.millisecondsSince1970)! - 5*60*1000))
        center.removePendingNotificationRequests(withIdentifiers: [deleteDate])
        let msg = KEY.MESSAGE.aptReminder + (modifiedApt?.patientName)! + KEY.MESSAGE.in_minutes + deleteDate
        for task in tasks {
            if task.name == msg{
                context.delete(task)
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                tasks = try context.fetch(Task.fetchRequest())
            }
            catch{
                print("Fetching failed.")
            }
        }
    }
}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
    
}

extension ConfirmAptViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.2352941176, blue: 0.5254901961, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if textField == txtSelectAppointmentType{
            setupPicker(textField: textField)
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

extension ConfirmAptViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 4
        textView.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.2352941176, blue: 0.5254901961, alpha: 1)
        textView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        temp = Int(scrollView.contentOffset.y)
        if scrollView.contentOffset.y == 0.0 {
            scrollView.contentOffset.y += 350
        } else {
            scrollView.contentOffset.y += 290
        }
        scrollView.isScrollEnabled = false
    return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        scrollView.contentOffset.y = CGFloat(temp)
        scrollView.isScrollEnabled = true
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderWidth = 0
        textView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.9882352941, alpha: 0.4155214271)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !txtViewNotes.text.isEmpty
    }
}


extension ConfirmAptViewController : UIPickerViewDelegate, UIPickerViewDataSource {
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
        
        txtSelectAppointmentType.text =  datasource[row]
    }
}

