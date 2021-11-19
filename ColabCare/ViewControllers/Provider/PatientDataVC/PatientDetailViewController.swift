//
//  PatientDetailViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/31/21.
//

import UIKit
import ChatSDK
import SDWebImage
import Charts
import SVProgressHUD
import CoreGraphics
class PatientDetailViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var btnGoals: UserDefineBtn!
    @IBOutlet weak var btnUsageStats: UserDefineBtn!
    @IBOutlet weak var btnMessage: UserDefineBtn!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    var patientData: PUser?
    var arrDates: [String] = []
    var arrMood: [Double] = []
    var arrMedication: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgProfile.layer.borderWidth = 1
        imgProfile.layer.borderColor = UIColor.black.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        btnMessage.layer.cornerRadius = btnMessage.frame.height/2
        barChartView.layer.cornerRadius = 12
        
    }
    
    @objc func respondToSwipeGestureRight(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                NotificationCenter.default.post(name: NSNotification.Name("rightPatientDetails"),object: nil)
                if patientData?.email() != tempPatientData?.email() {
                    viewWillAppear(true)
                    backgroundView.slideInFromLeft()
                }
                
            default:
                break
            }
        }
    }
    
    @objc func respondToSwipeGestureLeft(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .left:
                NotificationCenter.default.post(name: NSNotification.Name("leftPatientDetails"),object: nil)
                if patientData?.email() != tempPatientData?.email() {
                    viewWillAppear(true)
                    backgroundView.slideInFromRight()
                }
                
            default:
                break
            }
        }
    }
    
    
    @IBAction func btnGoalsTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Provider, nextVC: KEY.VIEWCONTROLLER.PatientGoalViewController)
        
    }
    @IBAction func btnUsageStatsTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Provider, nextVC: KEY.VIEWCONTROLLER.UsageStatisticsViewController)
        
    }
    func setupBarChart() {
        barChartView.delegate = self
        barChartView.largeContentTitle = KEY.PARAMETER.DailyCheckIn
        barChartView.chartDescription?.text = KEY.PARAMETER.Mood_vs_Medication
        barChartView.leftAxis.enabled = false
        barChartView.extraBottomOffset = 10
        
        //legend
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        
        let xaxis = barChartView.xAxis
        // xaxis.valueFormatter = axisFormatDelegate
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:self.arrDates)
        xaxis.granularity = 1
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.spaceBottom = 2
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        barChartView.rightAxis.enabled = false
        //axisFormatDelegate = self
        barChartView.noDataText = ""
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<self.arrMood.count {
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.arrMood[i]))
            dataEntries.append(dataEntry)
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: self.self.arrMedication[i])
            dataEntries1.append(dataEntry1)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: KEY.PARAMETER.Mood)
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: KEY.PARAMETER.Medication)
        chartDataSet.drawValuesEnabled = false
        chartDataSet1.drawValuesEnabled = false
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        let chartData = BarChartData(dataSets: dataSets)
        barChartView.data = chartData
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
        let groupCount = self.arrDates.count
        let startYear = 0
        chartData.barWidth = barWidth;
        barChartView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        barChartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChartView.notifyDataSetChanged()
        barChartView.data = chartData
        //background color
        //barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        barChartView.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8431372549, blue: 0.7568627451, alpha: 1)
        //chart animation
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        SVProgressHUD.dismiss()
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        moveTobackScreen()
    }
    
    func setupView() {
        imgProfile.sd_setImage(with: URL(string: (patientData?.imageURL())!), placeholderImage: UIImage(named: "user"))
        lblEmail.text = patientData?.email()!
        if patientData?.phoneNumber()! == "" {
            lblPhone.text = "Not Provided"
        } else {
            lblPhone.text = patientData?.phoneNumber()!
        }
        lblProfileName.text = patientData?.name()!
    }
    
    @IBAction func btnMessageTapped(_ sender: Any) {
        BChatSDK.thread().createThread(withUsers: [patientData]) { error, thread in
            threadUserName = thread?.displayName()
            threadUserProfile = thread?.imageURL()
            threadChat = thread
            let storyboard = UIStoryboard(name: KEY.STORYBOARD.Main, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.ChatThreadVC) as! ChatThreadVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        patientData = tempPatientData
        setupView()
        let containerOrigin = barChartView.frame.origin
        NavigationHeaderView.updateView(view: viewNavigation)
        changeBackground(view: view)
        UserDefineBtn.updateView(view: btnMessage)
        UserDefineBtn.updateView(view: btnUsageStats)
        UserDefineBtn.updateView(view: btnGoals)
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: -containerOrigin.x, vertical: -containerOrigin.y))
        SVProgressHUD.show()
        fetchPatientData(completion: { [self] (response) in
            if response! {
                setupBarChart()
            }
        })
        let marker:BalloonMarker = BalloonMarker(color: UIColor(red: 93/255, green: 186/255, blue: 215/255, alpha: 1), font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 25.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75.0, height: 35.0)//CGSize(75.0, 35.0)
        barChartView.marker = marker
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureRight))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureLeft))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    
    
    func fetchPatientData( completion: @escaping(Bool?) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            db.collection("user_data").document(patientData!.entityID()!).collection("dailyCheckIn").addSnapshotListener { [self]
                (querySnapshot, err) in
                arrDates.removeAll()
                arrMood.removeAll()
                arrMedication.removeAll()
                if let err = err
                {
                    print("Error getting documents: \(err)");
                    completion(false)
                }
                else
                {
                    for document in querySnapshot!.documents {
                        filterData(medication: document.data()["question6"] as! String, mood: document.data()["question1"] as! String, date: document.data()["date"] as! Int)
                    }
                    completion(true)
                }
                
                
            }
        }else {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
            completion(false)
        }
    }
    
    func filterData(medication: String, mood: String, date: Int) {
        if mood == KEY.MOOD.HAPPY {
            arrMood.append(7)
        } else if mood == KEY.MOOD.MOTIVATED {
            arrMood.append(6)
        } else if mood == KEY.MOOD.CALM {
            arrMood.append(5)
        } else if mood == KEY.MOOD.BLAH {
            arrMood.append(4)
        } else if mood == KEY.MOOD.SAD {
            arrMood.append(3)
        } else if mood == KEY.MOOD.STRESSED {
            arrMood.append(2)
        }  else if mood == KEY.MOOD.ANGRY {
            arrMood.append(1)
        }
        
        if medication == KEY.MESSAGE.took_all_medication {
            arrMedication.append(7)
            
        } else if medication == KEY.MESSAGE.some_medication{
            arrMedication.append(3.5)
        } else if medication == KEY.MESSAGE.did_not_take_medication{
            arrMedication.append(1)
        }
        let date = Date(milliseconds: Int64(exactly: date)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = KEY.DATEFORMAT.MM_dd
        let strDate = dateFormatter.string(from: date)
        arrDates.append(strDate)
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("chartValueSelected")
        print(entry.description)
    }
}

import Foundation
import Charts
#if canImport(UIKit)
import UIKit
#endif

open class BalloonMarker: MarkerImage
{
    @objc open var color: UIColor
    @objc open var arrowSize = CGSize(width: 15, height: 11)
    @objc open var font: UIFont
    @objc open var textColor: UIColor
    @objc open var insets: UIEdgeInsets
    @objc open var minimumSize = CGSize()
    
    fileprivate var label: String?
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedString.Key : Any]()
    
    @objc public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
        super.init()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = self.offset
        var size = self.size
        
        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }
        
        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0
        
        var origin = point
        origin.x -= width / 2
        origin.y -= height
        
        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
                origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - width - padding
        }
        
        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
                origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }
        
        return offset
    }
    
    
    func returnMood(mood: Int) -> String {
        if mood == 7 {
            return KEY.MOOD.HAPPY
        } else if mood == 6 {
            return KEY.MOOD.MOTIVATED
        } else if mood == 5 {
            return KEY.MOOD.CALM
        } else if mood == 4 {
            return KEY.MOOD.BLAH
        } else if mood == 3 {
            return KEY.MOOD.SAD
        } else if mood == 2 {
            return KEY.MOOD.STRESSED
        }  else  {
            return KEY.MOOD.ANGRY
        }
    }
    
    func retrunMedication(med: Double) -> String {
        if med == 7 {
            return KEY.MESSAGE.took_all_medication
        } else if med == 3.5{
            return KEY.MESSAGE.some_medication
        } else {
            return KEY.MESSAGE.did_not_take_medication
        }
    }
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let label = label else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()
        
        context.setFillColor(color.cgColor)
        
        if offset.y > 0
        {
            context.beginPath()
            context.move(to: CGPoint(
                            x: rect.origin.x,
                            y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                                y: rect.origin.y + arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                                x: point.x,
                                y: point.y))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + rect.size.width,
                                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + rect.size.width,
                                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                                x: rect.origin.x,
                                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                                x: rect.origin.x,
                                y: rect.origin.y + arrowSize.height))
            context.fillPath()
        }
        else
        {
            context.beginPath()
            context.move(to: CGPoint(
                            x: rect.origin.x,
                            y: rect.origin.y))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + rect.size.width,
                                y: rect.origin.y))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + rect.size.width,
                                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                                y: rect.origin.y + rect.size.height - arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                                x: point.x,
                                y: point.y))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                                x: rect.origin.x,
                                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                                x: rect.origin.x,
                                y: rect.origin.y))
            context.fillPath()
        }
        
        if offset.y > 0 {
            rect.origin.y += self.insets.top + arrowSize.height
        } else {
            rect.origin.y += self.insets.top
        }
        
        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        label.draw(in: rect, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        var barName = String(entry.x)
        if barName.contains(".32"){
            barName = KEY.PARAMETER.Mood
            setLabel(barName + ": " + returnMood(mood: Int(entry.y)))
        } else {
            barName = KEY.PARAMETER.Medication
            setLabel(barName + ": " + retrunMedication(med: entry.y))
        }
    }
    
    @objc open func setLabel(_ newLabel: String)
    {
        label = newLabel
        
        _drawAttributes.removeAll()
        _drawAttributes[.font] = self.font
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = self.textColor
        
        _labelSize = label?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
}

extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func slideInFromRight(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromRightTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromRightTransition.type = CATransitionType.push
        slideInFromRightTransition.subtype = CATransitionSubtype.fromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromRightTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
}
