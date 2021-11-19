//
//  PatientHomeViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/26/21.
//

import UIKit
import ChatSDK
import FSCalendar
import UserNotifications
class PatientHomeViewController: UIViewController {
    
    @IBOutlet weak var btnAddApt: UIButton!
    @IBOutlet weak var lblCurrentDay: UILabel!
    @IBOutlet weak var aptCalender: FSCalendar!
    @IBOutlet weak var tableViewApt: UITableView!
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    var arrApt = [Appointment]()
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice().type.rawValue == "iPhone 7" || UIDevice().type.rawValue == "iPhone 8" || UIDevice().type.rawValue == "iPhone 8 Plus" || UIDevice().type.rawValue == "iPhone 7 Plus" || UIDevice().type.rawValue == "iPhone SE (2nd generation)"  ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6S" ||  UIDevice().type.rawValue == "iPhone 6S Plus"{
            lblCurrentDay.font = lblCurrentDay.font.withSize(20)
        }
        //        UserDefaults.standard.removeObject(forKey: KEY.USERDEFAULT.aptArr)
        //        UserDefaults.standard.synchronize()
        deleteAllData(entity: KEY.COREDATA.ENTITY.ReminderData)
        self.navigationController?.setNavigationBarHidden(true, animated:true)
        btnAddApt.layer.cornerRadius = btnAddApt.frame.height/2
        aptCalender.delegate = self
        aptCalender.dataSource = self
        tableViewApt.delegate = self
        tableViewApt.dataSource = self
        appointments = getAptArr()
//        appointments.removeAll()
//        storeAptArr(arr: appointments)
        //center.removeAllPendingNotificationRequests()
        // Do any additional setup after loading the view.
        //08-14-2021
    }
    
    @IBAction func btnAddAptTapped(_ sender: Any) {
       // fromHome = -1
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Provider, nextVC: KEY.VIEWCONTROLLER.PatientDataViewController)
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.selectedIndex = 1
        NavigationHeaderView.updateView(view: viewNavigation)
        changeBackground(view: view)
       // fromHome = 1
        UserDefineBtn.updateView(view: btnAddApt as! UserDefineBtn)
        setFirstLogin()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.MM_dd_yyyy
        let date =  dateFormatter.string(from: Date())
        arrApt = getAptArr().filter({$0.date == date})
        setOnlyUpcommingAppointments()
        arrApt = arrApt.sorted(by: { $0.timeAndDate.timeIntervalSince1970 < $1.timeAndDate.timeIntervalSince1970 })
        tableViewApt.reloadData()
        aptCalender.reloadData()
        // just for checking remaining notification
        center.getPendingNotificationRequests { (notifications) in
            for item in notifications {
                print(item.content)
            }
            print("Count: \(notifications.count)")
        }
        if appointments.count == 0 {
            lblCurrentDay.text = BChatSDK.currentUser().name().contains("ChatSDK") ? "Hello" : "Hello " + BChatSDK.currentUser().name() + ", There are no upcoming appointments for today!"
        } else {
            lblCurrentDay.text = "Hello, " + BChatSDK.currentUser().name() + " These are the appointments for today!"
        }
        lblCurrentDay.textColor = returnThemeColor()
    }
    
    func setOnlyUpcommingAppointments() {
        var tempApts = [Appointment]()
        for apt in arrApt {
            if apt.timeAndDate.millisecondsSince1970 > Date().millisecondsSince1970 {
                tempApts.append(apt)
            } else {
                var totalArr = getAptArr()
                for i in 0...totalArr.count-1 {
                    if compareApptObj(obj1: totalArr[i], obj2: apt) {
                        totalArr.remove(at: i)
                        break
                    }
                }
                storeAptArr(arr: totalArr)
            }
        }
        appointments = getAptArr()
        arrApt = tempApts
    }
    
    func setFirstLogin() {
        if retriveEmail() == "" {
            let storyboard = UIStoryboard(name: KEY.STORYBOARD.Main, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.EditUserProfileViewController) as! EditUserProfileViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            storeEmail(email: "true")
        }
        
        if retriveEmail() != "" {
            let cvc = CurrentUser()
            cvc.username = retriveCurrentUser().username
            cvc.email = retriveCurrentUser().email
            cvc.profileURL = retriveCurrentUser().profileURL
            if userIndex == 0{
                cvc.userType = "PROVIDER"
            } else {
                cvc.userType = "PATIENT"
            }
        }
    }
    
}

extension PatientHomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrApt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KEY.CELL.AptTableViewCell) as! AptTableViewCell
        cell.lblTime.text = arrApt[indexPath.row].time!
        cell.selectionStyle = .none
        cell.lblNotes.text = arrApt[indexPath.row].notes!
        cell.lblTime.backgroundColor = returnThemeColor()
        cell.lblPatinet.text = arrApt[indexPath.row].patientName!
        if arrApt[indexPath.row].appointmentType == "Call" {
            cell.imgAppointmentType.image = UIImage(named: "call")
        } else if arrApt[indexPath.row].appointmentType == "Message" {
            cell.imgAppointmentType.image = UIImage(named: "chatting")
        } else if arrApt[indexPath.row].appointmentType == "Clinic" {
            cell.imgAppointmentType.image = UIImage(named: "pharmacy")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        modifiedApt = arrApt[indexPath.row]
        appointments = appointments.filter(){$0 != arrApt[indexPath.row]}
        let vc = self.storyboard?.instantiateViewController(withIdentifier: KEY.CELL.ConfirmAptViewController) as! ConfirmAptViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            var totalArr = getAptArr()
            for i in 0...totalArr.count-1 {
                if compareApptObj(obj1: totalArr[i], obj2: arrApt[indexPath.row]) {
                    totalArr.remove(at: i)
                    break
                }
            }
            deleteNotification(obj: arrApt[indexPath.row])
            storeAptArr(arr: totalArr)
            arrApt.remove(at: indexPath.row)
            aptCalender.reloadData()
        }
        tableViewApt.reloadData()
    }
    
    func deleteNotification(obj: Appointment) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.YY_MMM_D_HH_mm
        let deleteDate = dateFormatter.string(from: Date(milliseconds: obj.timeAndDate.millisecondsSince1970 - 5*60*1000))
        center.removePendingNotificationRequests(withIdentifiers: [deleteDate])
        let msg = KEY.MESSAGE.aptReminder + (obj.patientName)! + KEY.MESSAGE.in_minutes + deleteDate
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
    
    func compareApptObj(obj1:Appointment, obj2:Appointment) -> Bool {
        if obj1.date == obj2.date && obj1.notes == obj2.notes && obj1.patientName == obj2.patientName && obj1.timeAndDate == obj2.timeAndDate {
            return true
        } else {
            return false
        }
    }
    
    func filteredAndSortData() {
        
    }
}

extension PatientHomeViewController: FSCalendarDelegate, FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.MM_dd_yyyy
        let date =  dateFormatter.string(from: date)
        arrApt = getAptArr().filter({$0.date == date})
        arrApt = arrApt.sorted(by: { $0.timeAndDate.timeIntervalSince1970 < $1.timeAndDate.timeIntervalSince1970 })
        dateFormatter.dateFormat = KEY.DATEFORMAT.MM_dd_yyyy
        if dateFormatter.string(from: calendar.selectedDate!) == dateFormatter.string(from: Date()) {
            lblCurrentDay.text = KEY.MESSAGE.appForToday
        } else {
            lblCurrentDay.text = KEY.MESSAGE.APPFor + dateFormatter.string(from: calendar.selectedDate!)
        }
        tableViewApt.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.MM_dd_yyyy
        for getdate in getAptArr() {
            let strDate = dateFormatter.string(from: date)
            if getdate.date.compare(strDate) == .orderedSame  {
                return 1
            }
        }
        return 0
    }

    
}

