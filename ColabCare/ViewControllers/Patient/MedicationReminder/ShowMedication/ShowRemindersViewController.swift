


import UIKit
import UserNotifications
import CoreData


class ShowRemindersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tblViewReminder: UITableView!
    @IBOutlet weak var btnAddReminder: UserDefineBtn!
    var data = [[Reminder]]()
    let headerTitles = ["Today", "Upcoming"]
    var filteredData = [Reminder]()
    var imageView : UIImageView!
    var tasks: [Task] = []
    let center = UNUserNotificationCenter.current()
    
    @IBAction func btnExistTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //center.removeAllPendingNotificationRequests()
        tblViewReminder.showsHorizontalScrollIndicator = false
        allReminders = [Reminder]()
        allReminders = retrieveDataReminder(key: KEY.COREDATA.KEY.reminderData)
        removedReminderIfAlreadyPassed()
        //filteredData = filterOutData()
        data = filterOutData()
        tblViewReminder.reloadData()
        btnAddReminder.layer.cornerRadius = btnAddReminder.frame.height/2
        changeBackground(view: self.view)
        getData()
        center.getPendingNotificationRequests { (notifications) in
            for item in notifications {
                print(item.content)
            }
            print("Count: \(notifications.count)")
        }
    }
    
        func removedReminderIfAlreadyPassed() {
            let tempReminders = allReminders
                    for reminder in tempReminders {
                        if reminder.arrDates![reminder.arrDates!.count-1].millisecondsSince1970 < Date().millisecondsSince1970 {
                            allReminders.remove(at: tempReminders.firstIndex(of: reminder)!)
                        }
                    }
            deleteAllData(entity: KEY.COREDATA.ENTITY.ReminderData)
            createDataReminder(data: allReminders, key: KEY.COREDATA.KEY.reminderData)
        }
    @IBAction func btnAddReminderTapped(_ sender: Any) {
        medReminder = Reminder()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.ReminderSetViewController) as! ReminderSetViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewReminder.delegate = self
        tblViewReminder.dataSource = self
        self.tblViewReminder.isHidden = true
        assignbackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            self.imageView.isHidden = true
            self.tblViewReminder.isHidden = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = returnThemeColor()
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont(name: KEY.FONT.FUTURABOLD, size: 18)
    }
    
    
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            let fec: NSFetchRequest = Task.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "notificationTime", ascending: true)
            fec.sortDescriptors = [sortDescriptor]
            tasks = try context.fetch(fec)
        }
        catch{
            print("Fetching failed.")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewReminder.dequeueReusableCell(withIdentifier: "MedicationReminderTableViewCell") as! MedicationReminderTableViewCell
        if indexPath.row == 0 {
            cell.viewcontainerTopConstant.constant = 25
        }
        cell.lblMedicineName.text = data[indexPath.section][indexPath.row].medicineName
        cell.lblIntialDate.text = data[indexPath.section][indexPath.row].intialDate
        cell.lblMedicineDuration.isHidden = false
        cell.imgCalender.isHidden = false
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(btnEditTapped(_:)), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(btnDeleteTapped(_:)), for: .touchUpInside)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if ((data[indexPath.section][indexPath.row].duration)!.contains("days")){
            //cell.lblMedicineDuration.text = data[indexPath.section][indexPath.row].duration! + " left"
            // count how many days left from current date.
            let obj = data[indexPath.section][indexPath.row]
            cell.lblMedicineDuration.text = String(daysBetween(start: Date().stripTime(), end: obj.arrDates![obj.arrDates!.count-1].stripTime())) + " days left"
        } else if ((data[indexPath.section][indexPath.row].duration)!.contains("No End Date")) {
            cell.lblMedicineDuration.text = "Everyday"
        }
        else {
            cell.lblMedicineDuration.text = "Untill " + data[indexPath.section][indexPath.row].duration!
        }
        var timeStr = ""
        if data[indexPath.section][indexPath.row].medicineTime != nil{
            for time in data[indexPath.section][indexPath.row].medicineTime! {
                timeStr +=  time + ", "
            }
            let string = timeStr.dropLast(2)
            timeStr = String(string)
        }
        if (data[indexPath.section][indexPath.row].freqIntake)!.contains("Every"){
            cell.lblMedicineTime.text = data[indexPath.section][indexPath.row].freqIntake! + " " + timeStr
        } else {
            if data[indexPath.section][indexPath.row].medicineTime != nil{
                if (data[indexPath.section][indexPath.row].freqIntake)!.contains("days"){
                    cell.lblMedicineTime.text = String(data[indexPath.section][indexPath.row].medicineTime!.count) +  " times every " + (data[indexPath.section][indexPath.row].freqIntake)! + " at " + timeStr
                } else {
                    cell.lblMedicineTime.text = String(data[indexPath.section][indexPath.row].medicineTime!.count) + " times daily at " + timeStr
                }
            }
        }
        
        return cell
    }
    
    @objc func btnDeleteTapped(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tblViewReminder)
        guard let indexPath = self.tblViewReminder.indexPathForRow(at: buttonPosition) else { return }
        let totalDates = data[indexPath.section][indexPath.row].arrDates
        let times = data[indexPath.section][indexPath.row].medicineTime
        var sendingDates = [String]()
        for j in 0...times!.count-1{
            for i in 0...totalDates!.count-1 {
                let x = getDateFormat(date: totalDates![i].dateToString(), time: times![j])
                
                // Set Date Format
                var deleteDate = String()
                if ((data[indexPath.section][indexPath.row].duration)!.contains("No End Date")) {
                    //"1629004620000Daily1"
                    // if daily and day eg 2,3 present that means its daily reminder so find it and delete it
                    if (data[indexPath.section][indexPath.row].freqIntake)!.contains("days"){
                        deleteDate = String(x.millisecondsSince1970) + "Daily" + (data[indexPath.section][indexPath.row].freqIntake)!.westernArabicNumeralsOnly
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
        deleteTask(dates: sendingDates, medName:data[indexPath.section][indexPath.row].medicineName!)
        if allReminders.contains(data[indexPath.section][indexPath.row]) {
            let index = allReminders.firstIndex(of: data[indexPath.section][indexPath.row])
            allReminders.remove(at: index!)
        }
        if filteredData.contains(data[indexPath.section][indexPath.row]) {
            let index = filteredData.firstIndex(of: data[indexPath.section][indexPath.row])
            filteredData.remove(at: index!)
        }
        data = [filteredData,allReminders]
        deleteAllData(entity: KEY.COREDATA.ENTITY.ReminderData)
        createDataReminder(data: allReminders, key: KEY.COREDATA.KEY.reminderData)
        tblViewReminder.reloadData()
        //        storeInMemory()
    }
    
    
    func getDates(from fromDate: Date, to toDate: Date) -> [Date] {
        var date = fromDate
        var tempDates = [Date]()
        let tempMessages = [String]()
        while date <= toDate {
            tempDates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return tempDates
    }
    
    
    
    @objc func btnEditTapped(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tblViewReminder)
        guard let indexPath = self.tblViewReminder.indexPathForRow(at: buttonPosition) else { return }
        medReminder = data[indexPath.section][indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.ReminderSetViewController) as! ReminderSetViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //Note: This function is use for filtered out remiinders today and upcoming reminders.
    //    func filterOutData() -> [Reminder]{
    //        let remindersData = retrieveDataReminder(key: KEY.COREDATA.KEY.reminderData)
    //        var rems =  [Reminder]()
    //        for reminder in remindersData {
    //            reminder.dat
    //            var date = Date()
    //            var toDate = Date()
    //            let startDate = reminder.intialDate!.convertToDate()
    //            if reminder.duration!.contains("No End Date") {
    //                if reminder.intialDate!.convertToDate() == Date().stripTime(){
    //                    rems.append(reminder)
    //                }
    //            } else {
    //                if reminder.duration!.contains("days"){
    //                    toDate = getEndDateUsingDays(intialDate: startDate, duration: reminder.duration!)
    //                } else {
    //                    date = startDate
    //                    toDate = reminder.duration!.convertToDate()
    //                }
    //                while date <= toDate {
    //                    if date == Date().stripTime() || date == currentDateOnlyTime() {
    //                        rems.append(reminder)
    //                    }
    //                    guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
    //                    date = newDate
    //                }
    //            }
    //        }
    //        return rems
    //    }
    
    func filterOutData() -> [[Reminder]]{
        let remindersData = retrieveDataReminder(key: KEY.COREDATA.KEY.reminderData)
        var rems1 =  [Reminder]()
        var rems2 = [Reminder]()
        for reminder in remindersData  {
            var dates = [Int64]()
            for rems in reminder.arrDates ?? []{
                dates.append(rems.stripTime().millisecondsSince1970)
            }
            if dates.contains(Date().stripTime().millisecondsSince1970) && reminder.arrDates![dates.firstIndex(of: Date().stripTime().millisecondsSince1970)!].millisecondsSince1970 > Date().millisecondsSince1970 {
                rems1.append(reminder)
            } else {
                rems2.append(reminder)
            }
        }
        return [rems1,rems2]
    }
    
    //Note: This function is mainly use for getting end days based on given days and starting date.
    func getEndDateUsingDays(intialDate: Date, duration: String) -> Date {
        var modifiedDate = intialDate
        let array = duration.components(separatedBy: " ")
        var i = 0
        while i < Int(array[0])! {
            modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: modifiedDate)!
            i += 1
        }
        return modifiedDate
    }
    
    func assignbackground(){
        do {
            let imageData = try Data(contentsOf: Bundle.main.url(forResource: "medicine", withExtension: "gif")!)
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
    
    func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
}

extension UIViewController {
    func deleteTask(dates: [String], medName: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var identifireArr = [String]()
        for date in dates {
            identifireArr.append(KEY.MESSAGE.reminder_message + medName + date)
        }
        for task in tasks {
            if identifireArr.contains(task.name!){
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
