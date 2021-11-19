//
//  UsageStatisticsViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 8/9/21.
//

import UIKit
import FSCalendar
import ChatSDK
class UsageStatisticsViewController: UIViewController {
    
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    @IBOutlet weak var tblViewStats: UITableView!
    @IBOutlet weak var calender: FSCalendar!
    var patientData: PUser?
    var usgeModules = [UsageModules]()
    var usgeInfo = [UsageStatsInfo]()
    var dates = [String]()
    var selectedDataSource = UsageStatsInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewStats.delegate = self
        calender.delegate = self
         calender.dataSource = self
        tblViewStats.dataSource = self
        patientData = tempPatientData
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHeaderView.updateView(view: viewNavigation)
        changeBackground(view: view)
        fetchStatsData { [self] flag in
            if flag! {
                filterDataSource(date: Date())
                tblViewStats.reloadData()
                calender.reloadData()
            }
        }
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        moveTobackScreen()
    }
    
    func fetchDateByDateData(date: Date = Date(), completion: @escaping(UsageStatsInfo?) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        let strDate = dateFormatter.string(from: date)
        let docRef = db.collection("user_data").document((patientData?.entityID())!).collection("usageStatistics").document(strDate)
        docRef.getDocument { [self](document, error) in
            if document!.exists {
                let obj = UsageStatsInfo()
                obj.date = (document!["date"] as! String)
                dates.append(obj.date)
                var objModules = [UsageModules]()
                for mod in document!["modules"] as! [[String:Any]] {
                    let infoMod = UsageModules()
                    infoMod.count = (mod["count"] as! Int)
                    var usageInfoObjs = [UsageInfo]()
                    for info in mod["info"] as![[String:Any]] {
                        usageInfoObjs.append(UsageInfo(fromDictionary: info ))
                    }
                    infoMod.usageInfo = usageInfoObjs
                    infoMod.meditationTitle = (mod["meditationTitle"] as! String)
                    infoMod.meditationId = (mod["meditationId"] as! Int)
                    objModules.append(infoMod)
                }
                obj.modules = objModules
                usgeModules = obj.modules
                completion(obj)
            }
        }

        
    }
    func fetchStatsData(startDate: Date = Date(), endDate: Date = Date(), completion: @escaping(Bool?) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            DispatchQueue.main.async { [self] in
                for date in startDate.getAllDays(){
                    fetchDateByDateData(date:date) { [self] info in
                        usgeInfo.append(info!)
                        completion(true)
                    }
                }
            }
        } else {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
            completion(false)
        }
    }
    
    func filterDataSource(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        let strDate = dateFormatter.string(from: date)
        for info in usgeInfo {
            if strDate == info.date {
                selectedDataSource = info
            }
        }
    }
}

extension Date
{
    mutating func addDays(n: Int)
    {
        let cal = Calendar.current
        self = cal.date(byAdding: .day, value: n, to: self)!
    }
    
    func firstDayOfTheMonth() -> Date {
        return Calendar.current.date(from:
                                        Calendar.current.dateComponents([.year,.month], from: self))!
    }
    
    func getAllDays() -> [Date]
    {
        var days = [Date]()
        
        let calendar = Calendar.current
        
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        var day = firstDayOfTheMonth()
        
        for _ in 1...range.count
        {
            days.append(day)
            day.addDays(n: 1)
        }
        
        return days
    }
}


extension UsageStatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedDataSource.date == nil{
        return 0
        } else {
            return selectedDataSource.modules.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UsageStatisticsTableViewCell = tableView.dequeueReusableCell(withIdentifier: KEY.CELL.UsageStatisticsTableViewCell) as! UsageStatisticsTableViewCell
        cell.lblMeditationName.text = String(indexPath.row + 1) + ". " +  selectedDataSource.modules[indexPath.row].meditationTitle
        cell.viewBg.layer.cornerRadius = 12
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UsageStatisticsDetailsViewController.detailInfo = selectedDataSource.modules[indexPath.row]
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Provider, nextVC: KEY.VIEWCONTROLLER.UsageStatisticsDetailsViewController)
    }
    
    
}

extension UsageStatisticsViewController: FSCalendarDelegate, FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        filterDataSource(date: date)
        tblViewStats.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.MM_dd_yyyy
        for getdate in dates {
            let strDate = dateFormatter.string(from: date)
            if getdate.compare(strDate) == .orderedSame  {
                return 1
            }
        }
        return 0
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        fetchStatsData(startDate:calendar.currentPage) { [self] flag in
            if flag! {
                filterDataSource(date: Date())
                tblViewStats.reloadData()
                calender.reloadData()
            }
        }
    }
    
}


