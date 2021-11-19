//
//  ReminderSetViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 6/4/21.
//

import UIKit
import CoreData
import UserNotifications

class ReminderSetViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var constraintTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAddReminder: UserDefineBtn!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tblViewMedicine: UITableView!
    @IBOutlet weak var lblFrequency: UILabel!
    @IBOutlet weak var lblSelectedDuration: UILabel!
    @IBOutlet weak var txtMedicineName: PaddedTextField!
    @IBOutlet weak var reminderTableView: UITableView!
    let center = UNUserNotificationCenter.current()
    var medicines = ["Bupropion (Wellbutrin)", "Citalopram (Celexa)", "Duloxetine (Cymbalta)","Escitalopram (Lexapro)","Fluoxetine (Prozac)","Mirtazapine (Remeron)","Paroxetine (Paxil)","Sertraline (Zoloft)","Venlafaxine (Effexor)","Nortriptyline (Pamelor)","Alprazolam (Xanax)","Amitriptyline (Elavil)","Clonazepam (Klonopin)","Diazepam (Valium)","Lorazepam (Ativan)","Buspirone (Buspar)","Hydroxyzine (Vistaril)","Prazosin (Minipress)","Trazodone (Desyrel)","Zolpidem (Ambien)","Divalproex (Depakote)","Lamotrigine (Lamictal)","Lithium","Aripiprazole (Abilify)","Lurasidone (Latuda)","Olanzapine (Zyprexa)","Quetiapine (Seroquel)","Risperidone (Risperdal)"]
    var txtContainer = UITextField()
    var txtContainerDosage = UITextField()
    let datePicker = UIDatePicker()
    var editReminder = Reminder()
    var i = 0
    var isEmpty = false
    var copyarr = [String]() // it is local variable and it is intialize when user want to edit existing medicine remider information.
    var arrMedicine: [String]? = nil
    var cntArr = [Int]()
    var dataSource = [String]()
    var searchText: String = ""
    var medicineData: [[String: String]] = []
    var arrMedicineData: [[String: String]] = []
    var arrDos: [String]? // use for stroing selected dosage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtContainer.delegate = self
        txtContainerDosage.delegate = self
        btnAddReminder.layer.cornerRadius = btnAddReminder.frame.height/2
        tblViewMedicine.delegate = self
        txtMedicineName.delegate = self
        tblViewMedicine.dataSource = self
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
        startDate = "Today"
        for med in medicines{
            medicineData.append(["name":med])
        }
        arrMedicineData = medicineData
        tblViewMedicine.isHidden = true
        frequencyGlobal = "Daily"
        durationGlobal = "No End Date"
        NotificationCenter.default
            .addObserver(self,
                         selector:#selector(enableScroll(_:)),
                         name: NSNotification.Name ("enableScrollTableView"),object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        var tableViewHeight: CGFloat = 0
        for section in 0..<tblViewMedicine.numberOfSections {
            for row in 0..<tblViewMedicine.numberOfRows(inSection: section) {
                tableViewHeight += tableView(tblViewMedicine, heightForRowAt: IndexPath(row: row, section: section))
            }
        }
        constraintTableViewHeight.constant = tableViewHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // self.baseView.backgroundColor = UIColor(patternImage: UIImage(named: "Reminder")!)
        tblViewMedicine.layer.borderWidth = 1
        tblViewMedicine.layer.cornerRadius = 7
        tblViewMedicine.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        txtMedicineName.attributedPlaceholder = NSAttributedString(string: "Medicine Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        if durationGlobal != nil{
            lblSelectedDuration.text = durationGlobal
        }
        if frequencyGlobal != nil{
            lblFrequency.text = frequencyGlobal
        }
        retriveObjData()
        if medReminder.medicineName != nil {
            editReminder = medReminder
            for j in 0...medReminder.medicineTime!.count - 1 {
                cntArr.append(j)
                copyarr.append(medReminder.medicineTime![i])
                i += 1
            }
        }
        UserDefineBtn.updateView(view: btnAddReminder)
        changeBackground(view: self.baseView)
    }
    
    @IBAction func btnExistTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDurationTapped(_ sender: Any) {
        // moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Main, nextVC: KEY.VIEWCONTROLLER.DurationViewController)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.DurationViewController) as! DurationViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnFrequencyTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.FrequencyOfIntakeViewController) as! FrequencyOfIntakeViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnAddReminderTapped(_ sender: Any) {
        i += 1
        cntArr.append(i)
        reminderTableView.reloadData()
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        if txtMedicineName.text!.isEmpty{
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.enter_medicine_name)
            return
            
        } else if i <= 0 {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.choose_medicine_time)
            return
        } else {
            arrMedicine = [String]()
            arrDos = [String]()
            self.reminderTableView.reloadData()
        }
    }
    
    func storeDataInObj(){
        if editReminder.medicineName != nil { // Using this we can check we are in editng mode or storing mode.
            for message in editReminder.arrMessages! {
                reminderString = reminderString.filter { $0 != message }
            }
            for date in editReminder.arrDates! {
                reminderdates = reminderdates.filter { $0 != date }
            }
            if let index = allReminders.firstIndex(of: editReminder) {
                allReminders.remove(at: index)
            }
            deleteIfUpdateHappens()
        }
        if arrMedicine!.count <= 0 || arrMedicine!.contains(""){
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.choose_medicine_time)
            return
        }
        if arrDos!.count <= 0 || arrDos!.contains(""){
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.choose_dosage)
            return
        }
        if startDate == "Today"{
            medReminder.intialDate = Date().stripTime().dateToString()
        } else {
            medReminder.intialDate = startDate
        }
        //        resetTrackingData()
        medReminder.medicineName = txtMedicineName.text
        medReminder.medicineTime = arrMedicine
        medReminder.arrDosage = arrDos
        medReminder.duration = lblSelectedDuration.text
        medReminder.freqIntake = lblFrequency.text
        allReminders.append(medReminder)
        processReminders()
//        storeInMemory()
        deleteAllData(entity: KEY.COREDATA.ENTITY.ReminderData)
        createDataReminder(data: allReminders, key: KEY.COREDATA.KEY.reminderData)
        self.dismiss(animated: true)
    }
    @objc func enableScroll(_ notification: Notification){
        reminderTableView.isScrollEnabled = true
    }
    
}

extension ReminderSetViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == reminderTableView{
            if medReminder.medicineName != nil {
                return medReminder.medicineTime!.count
            } else {
                return cntArr.count
            }
        } else {
            return arrMedicineData.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == reminderTableView{
            if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
                if indexPath == lastVisibleIndexPath {
                    medReminder = Reminder()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == reminderTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderSetTableViewCell") as! ReminderSetTableViewCell
            if medReminder.medicineName != nil {
                cell.txtTime.text = medReminder.medicineTime![indexPath.row]
                cell.txtDosage.text = medReminder.arrDosage![indexPath.row]
            }
            if arrMedicine != nil {
                arrMedicine!.append(cell.txtTime.text!)
                arrDos!.append(cell.txtDosage.text!)
                if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
                    if indexPath == lastVisibleIndexPath {
                        storeDataInObj()
                    }
                }
            }
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(btnDeleteTapped(_:)), for: .touchUpInside)
            cell.txtTime.tag = indexPath.row
            cell.txtTime.addTarget(self, action: #selector(ReminderSetViewController.textFieldDidChangeDate(_:)),
                                   for: .editingDidBegin)
            cell.txtDosage.addTarget(self, action: #selector(ReminderSetViewController.textFieldDidChangeDosage(_:)),
                                     for: .editingDidBegin)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "MedicineTableViewCell") as? MedicineTableViewCell)!
            var Data  = arrMedicineData[indexPath.row]
            cell.lblMedicineName.text = Data["name"]
            return cell
        }
    }
    
    @objc func textFieldDidChangeDosage(_ textField: UITextField) {
        reminderTableView.isScrollEnabled = false
    }
    
    
    
    @objc func btnDeleteTapped(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.reminderTableView)
        guard let indexPath = self.reminderTableView.indexPathForRow(at: buttonPosition) else { return }
        let cell = reminderTableView.cellForRow(at: indexPath) as! ReminderSetTableViewCell
        cell.txtTime.text = nil
        reminderTableView.dataSource?.tableView!(reminderTableView, commit: .delete, forRowAt: indexPath)
        if i == 0 {
            arrMedicine = nil  // if all selected medicines are deleted then set dos and medicine name to nil
            arrDos = nil
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView == reminderTableView{
            return true
        } else {
            return true
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == reminderTableView{
            return 50
        } else {
            return 50
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblViewMedicine{
            let data = arrMedicineData[indexPath.row]
            txtMedicineName.text = data["name"]
            tblViewMedicine.isHidden = true
            view.endEditing(true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == reminderTableView{
            if (editingStyle == .delete) {
                reminderTableView.beginUpdates()
                i -= 1
                cntArr.remove(at: indexPath.row)
                if copyarr.count > indexPath.row{
                    copyarr.remove(at: indexPath.row)
                }
                reminderTableView.deleteRows(at: [indexPath], with: .automatic)
                reminderTableView.endUpdates()
            }
        }
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    @objc func donedatePickerFirstDose(_ sender:UITextField) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let time = formatter.string(from: datePicker.date)
        txtContainer.text = time
        //arr.append(time)
        reminderTableView.isScrollEnabled = true
        self.view.endEditing(true)
        txtContainer.isUserInteractionEnabled = true
    }
    
    
    @objc func textFieldDidChangeDate(_ textField: UITextField) {
        reminderTableView.isScrollEnabled = false
        datePicker.datePickerMode = .time
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } 
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePickerFirstDose))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        txtContainer = textField
    }
    
    
    func deleteIfUpdateHappens() {
        let totalDates = editReminder.arrDates
        let times = editReminder.medicineTime
        var sendingDates = [String]()
        for j in 0...times!.count-1{
            for i in 0...totalDates!.count-1 {
                let x = getDateFormat(date: totalDates![i].dateToString(), time: times![j])
                var deleteDate = String()
                if ((editReminder.duration)!.contains("No End Date")) {
                    //"1629004620000Daily1"
                    // if daily and day eg 2,3 present that means its daily reminder so find it and delete it
                        if (editReminder.freqIntake)!.contains("days"){
                            deleteDate = String(x.millisecondsSince1970) + "Daily" + (editReminder.freqIntake)!.westernArabicNumeralsOnly
                        } else {
                            //if daily not every 3 ,4,5
                            deleteDate = String(x.millisecondsSince1970) + "Daily1"
                        }
                } else {
                    deleteDate = String(x.millisecondsSince1970)
                }
                center.removePendingNotificationRequests(withIdentifiers: [deleteDate])
                sendingDates.append(deleteDate)
            }
        }
        deleteTask(dates: sendingDates, medName:editReminder.medicineName!)
    }
    func processReminders(){
        var startDateReminder = Date()
        var endDateReminder = Date()
        if startDate!.contains("Today"){
            startDateReminder = Date().stripTime()
        } else {
            startDateReminder = (startDate?.convertToDate())!
        }
        if durationGlobal!.contains("days"){
            var modifiedDate = Date()
            let array = durationGlobal!.components(separatedBy: " ")
            var i = 0
            while i < Int(array[0])! {
                modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: modifiedDate)!
                i += 1
            }
            endDateReminder = modifiedDate
            addTimeToDate(startDateReminder: startDateReminder, endDateReminder: endDateReminder)
        } else if durationGlobal! != "No End Date"{
            endDateReminder = (durationGlobal?.convertToDate())!
            addTimeToDate(startDateReminder: startDateReminder, endDateReminder: endDateReminder)
        } else {
            var tempDates = [Date]()
            var tempMessages = [String]()
            for time in medReminder.medicineTime! {
                let getDate =  getDateFormat(date: Date().dateToString(), time: time)
                if getDate.timeIntervalSince1970 > Date().timeIntervalSince1970{
                tempDates.append(getDate)
                } else {
                    if lblFrequency.text == "Daily" {
                    tempDates.append(Date(milliseconds: getDate.millisecondsSince1970 + Int64(1440*60*1000)))
                    } else {
                        tempDates.append(Date(milliseconds: getDate.millisecondsSince1970 + Int64(Int(lblFrequency.text!.westernArabicNumeralsOnly)!*1440*60*1000)))
                    }
                }
                tempMessages.append(KEY.MESSAGE.reminder_message + medReminder.medicineName!)

            }
            var frequentRepeat = String()
            if lblFrequency.text == "Daily" {
                frequentRepeat = "Daily1"
            } else {
                frequentRepeat = "Daily" +  lblFrequency.text!.westernArabicNumeralsOnly
            }
            medReminder.arrMessages = tempMessages
            medReminder.arrDates = tempDates
            for i in 0...medReminder.arrDates!.count - 1 {
                if medReminder.arrDates![i].timeIntervalSince1970 > Date().timeIntervalSince1970  {
                    addTask(givenDate: medReminder.arrDates![i], message: medReminder.arrMessages![i],daily: frequentRepeat)
                } else {
                    // if time already passed for today but reminder is daily then sheduled it for today
                    let givenDate = Date(milliseconds: medReminder.arrDates![i].millisecondsSince1970 + Int64(1440*60*1000))
                    addTask(givenDate: givenDate, message: medReminder.arrMessages![i],daily: frequentRepeat)
                }
            }
        }
    }
    
    func addTimeToDate(startDateReminder: Date, endDateReminder: Date){
        for time in medReminder.medicineTime! {
            let x = getDateFormat(date: startDateReminder.dateToString(), time: time)
            let y = getDateFormat(date: endDateReminder.dateToString(), time: time)
            let datesBetweenArray = Date.dates(from: x, to: y)
            for i in 0...medReminder.arrDates!.count - 1 {
                if medReminder.arrDates![i].timeIntervalSince1970 > Date().timeIntervalSince1970  {
                    addTask(givenDate: medReminder.arrDates![i], message: medReminder.arrMessages![i])
                }
            }
        }
    }
    func getFullDate(time: String) -> Date{
        let stripDate =  Date().stripTime().dateToString()
        let date = getDateFormat(date: stripDate, time: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let strCurrDate = dateFormatter.string(from: date)
        let pDate = "0002-01-01T" + strCurrDate.components(separatedBy: " ")[1] + "+0000"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from:pDate)!
    }
    
    func retriveObjData() {
        if medReminder.medicineName != nil {
            txtMedicineName.text = medReminder.medicineName!
        }
        if medReminder.duration != nil {
            lblSelectedDuration.text = medReminder.duration!
            startDate = medReminder.intialDate
            durationGlobal = medReminder.duration!
            
        }
        if medReminder.freqIntake != nil {
            lblFrequency.text = medReminder.freqIntake!
            frequencyGlobal = medReminder.freqIntake!
        }
    }
    
}
extension String {
    func convertToDate() -> Date {
        let string = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.date(from: string)!
    }
}


extension ReminderSetViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.2352941176, blue: 0.5254901961, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        textField.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.9882352941, alpha: 0.42)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtContainer || textField == txtContainerDosage {
            return false; //do not show keyboard nor cursor
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtMedicineName {
            self.tblViewMedicine.isHidden = true
            arrMedicineData.removeAll()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isEmpty = false
        if string.isEmpty {
            searchText = String(searchText.dropLast())
            if (txtMedicineName.text?.dropLast().isEmpty)! {
                self.tblViewMedicine.isHidden = true
                isEmpty = true
            }
        } else {
            searchText=textField.text!+string
        }
        print(searchText)
        let predicate=NSPredicate(format:"SELF.name CONTAINS[cd] %@",searchText)
        let arr = (medicineData as NSArray).filtered(using: predicate)
        var flag = false
        if arr.count > 0
        {
            arrMedicineData.removeAll(keepingCapacity: true)
            arrMedicineData = arr as! [[String: String]]
        }
        else
        {
            arrMedicineData = medicineData
            flag = true
        }
        if !self.isEmpty {
            if flag {
                self.tblViewMedicine.isHidden = true
            } else {
                self.tblViewMedicine.isHidden = false
            }
        }
        tblViewMedicine.reloadData()
        viewDidLayoutSubviews()
        return true
    }
}

extension Date {
    static func dates(from fromDate: Date, to toDate: Date) {
        var date = fromDate
        var tempDates = [Date]()
        var tempMessages = [String]()
        while date <= toDate {
            if !reminderdates.contains(date){
                reminderdates.append(date)
                reminderString.append(KEY.MESSAGE.reminder_message + medReminder.medicineName!)
                tempDates.append(date)
                tempMessages.append(KEY.MESSAGE.reminder_message + medReminder.medicineName!)
            }
            var getNewDate = Date()
            if frequencyGlobal!.contains("Daily") {
                guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
                getNewDate = newDate
            } else {
                let array = frequencyGlobal!.components(separatedBy: " ")
                guard let newDate = Calendar.current.date(byAdding: .day, value: Int(array[0])!, to: date) else { break }
                getNewDate = newDate
            }
            date = getNewDate
        }
        medReminder.arrDates = tempDates
        medReminder.arrMessages = tempMessages
    }
    
    
    
    
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = KEY.DateTime.DateFormat
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return  formatter.string(from: self)
    }
}

extension String {
    var trimmingTrailingSpaces: String {
        if let range = rangeOfCharacter(from: .whitespacesAndNewlines, options: [.anchored, .backwards]) {
            return String(self[..<range.lowerBound]).trimmingTrailingSpaces
        }
        return self
    }
}

extension UIViewController {
    
    func getDateFormat(date: String, time: String) -> Date{
        let array = date.components(separatedBy: ", ")
        let subarray = array[0].components(separatedBy: " ")
        let date = array[1] + ", " + subarray[0] + " " + subarray[1]
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "YYYY, MMM d 'at' h:mm a"
        let string = date + " at " + time                       // "March 24, 2017 at 7:00 AM"
        return dateFormatter.date(from: string)!
    }
    
    func createDataReminder(data: [Reminder], key: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: KEY.COREDATA.ENTITY.ReminderData, in: managedContext)!
        let cmsg = NSManagedObject(entity: userEntity, insertInto: managedContext) as! ReminderData
        let mRanges = Reminders(Reminders: data)
        cmsg.setValue(mRanges, forKeyPath: key)
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func retrieveDataReminder(key: String) -> [Reminder] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        var sendData = [Reminder]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: KEY.COREDATA.ENTITY.ReminderData)
        do {
            let result = try managedContext.fetch(fetchRequest)
            var i = 0
            for data in result as! [NSManagedObject] {
                let mranges = data.value(forKey: key) as? Reminders
                if mranges != nil {
                    for element in mranges!.Reminders {
                        sendData.append(element)
                    }
                    i = i + 1
                }
            }
            
        } catch {
            
            print("Failed")
        }
        return sendData
    }
}
extension String {
    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
                        .flatMap { pattern ~= $0 ? Character($0) : nil })
    }
}
