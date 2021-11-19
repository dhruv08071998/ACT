//
//  UsageStatisticsDetailsViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 8/9/21.
//

import UIKit

class UsageStatisticsDetailsViewController: UIViewController {

    @IBOutlet weak var tblViewInfo: UITableView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    @IBOutlet weak var lblTotalDuration: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblMeditationTitle: UILabel!
    static var detailInfo = UsageModules()
    var totalSec = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewInfo.delegate = self
        tblViewInfo.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHeaderView.updateView(view: viewNavigation)
        changeBackground(view: view)
        viewInfo.layer.cornerRadius = 12
        tblViewInfo.layer.cornerRadius = 12
        lblMeditationTitle.textColor = returnThemeColor()
        viewInfo.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tblViewInfo.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lblMeditationTitle.text = String(UsageStatisticsDetailsViewController.detailInfo.meditationTitle)
        lblCount.text = String(UsageStatisticsDetailsViewController.detailInfo.count)
        for info in UsageStatisticsDetailsViewController.detailInfo.usageInfo {
            totalSec += Double(info.timeProgress)
        }
        lblTotalDuration.text = String(totalSec.asString(style: .abbreviated))
        tblViewInfo.reloadData()
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        moveTobackScreen()
    }
    
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }
    
    func returnOnlyTime(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.HH_mm_ss_a
        return dateFormatter.string(from: date)
    }
}

extension UsageStatisticsDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsageStatisticsDetailsViewController.detailInfo.usageInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UsageStatisticsDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: KEY.CELL.UsageStatisticsDetailsTableViewCell) as! UsageStatisticsDetailsTableViewCell
        let startDate = Date(timeIntervalSince1970: Double(UsageStatisticsDetailsViewController.detailInfo.usageInfo[indexPath.row].startTime))
        let endDate = Date(timeIntervalSince1970: Double(UsageStatisticsDetailsViewController.detailInfo.usageInfo[indexPath.row].endTime))
        cell.lblStartTime.text = "Start Time: " + returnOnlyTime(date: startDate)
        cell.lblEndTime.text = "End Time: " + returnOnlyTime(date: endDate)
        totalSec += Double(UsageStatisticsDetailsViewController.detailInfo.usageInfo[indexPath.row].timeProgress)
        cell.lblDuration.text = "Duration: " +  String(UsageStatisticsDetailsViewController.detailInfo.usageInfo[indexPath.row].timeProgress) + " " + "s"
        return cell
    }
    
    
}

extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    return formatter.string(from: self) ?? ""
  }
}

