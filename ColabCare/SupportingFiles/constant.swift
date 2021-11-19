//
//  constant.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 5/20/21.
//

import Foundation
import UIKit
import UserNotifications
import CoreData
import ChatSDK
import FirebaseFirestore
import SVProgressHUD
struct KEY {
    
    struct PARAMETER {
        static let goalName = "goalName"
        static let goalId = "goalId"
        static let notes = "Notes"
        static let intialDate = "intialDate"
        static let completedBy = "completedBy"
        static let textColor = "textColor"
        static let done = "Done"
        static let all = "All"
        static let Completed = "Completed"
        static let inProgress = "In Progress"
        static let Notes = "Notes"
        static let clinic = "Clinic"
        static let message = "Message"
        static let call = "Call"
        static let cancel = "Cancel"
        static let Reminder = "Reminder"
        static let DailyCheckIn = "Daily Check-In"
        static let Mood_vs_Medication = "Mood vs Medication"
        static let Mood = "Mood"
        static let Medication = "Medication"
        static let Mindfulness = "Mindfulness"
        static let four_seven_eight_BreathingExercise = "4-7-8 Breathing Exercise"
    }
    
    struct MOOD {
        static let HAPPY = "HAPPY"
        static let MOTIVATED = "MOTIVATED"
        static let CALM = "CALM"
        static let STRESSED = "STRESSED"
        static let BLAH = "BLAH"
        static let SAD = "SAD"
        static let ANGRY = "ANGRY"
    }
    struct USERTYPE {
        static let Provider = "Provider"
        static let Patient = "Patient"
    }
    struct STORYBOARD {
        static let Main = "Main"
        static let MedReminder = "MedReminder"
        static let Authentication = "Authentication"
        static let Provider = "Provider"
    }
    struct EXTENSION {
        static let pdf = ".pdf"
    }
    struct PASSWORD {
        static let password = "Callan2018!"
    }
    struct PROFILE {
        static let IMG = "IMAGE"
        static let DESC = "DESC"
        static let NAME = "NAME"
    }
    struct USERDEFAULT {
        static let email = "email"
        static let goalId = "goalId"
        static let themeFlag = "themeFlag"
        static let currentUser = "currentUser"
        static let dailyQues = "dailyQues"
        static let aptArr = "aptArr"
    }
    struct NOTIFICATION {
        static let login = "login"
    }
    struct VIEWCONTROLLER {
        static let UsageStatisticsDetailsViewController = "UsageStatisticsDetailsViewController"
        static let UsageStatisticsViewController = "UsageStatisticsViewController"
        static let UserTypeViewController = "UserTypeViewController"
        static let EditUserProfileViewController = "EditUserProfileViewController"
        static let AddGoalViewController = "AddGoalViewController"
        static let CurrentGoalViewController = "CurrentGoalViewController"
        static let CompletedGoalViewController = "CompletedGoalViewController"
        static let ScreeningQuestionViewController = "ScreeningQuestionViewController"
        static let DisorderAnxietyViewController = "DisorderAnxietyViewController"
        static let TabBarViewController = "TabBarViewController"
        static let MedicationNameViewController = "MedicationNameViewController"
        static let MedicationDateViewController = "MedicationDateViewController"
        static let MedicineDailyViewController = "MedicineDailyViewController"
        static let MedicineOftenViewController = "MedicineOftenViewController"
        static let MedicineTimeViewController = "MedicineTimeViewController"
        static let MedicationWeekViewController = "MedicationWeekViewController"
        static let MedicationDaysViewController = "MedicationDaysViewController"
        static let MedicationAllSetViewController = "MedicationAllSetViewController"
        static let HomeViewController = "HomeViewController"
        static let ReminderSetViewController = "ReminderSetViewController"
        static let FrequencyOfIntakeViewController = "FrequencyOfIntakeViewController"
        static let DurationViewController = "DurationViewController"
        static let ProfileViewController = "MyProfileViewController"
        static let ChangeThemeViewController = "ChangeThemeViewController"
        static let LoginViewController = "LoginViewController"
        static let PatientGoalViewController = "PatientGoalViewController"
        static let ChatViewController = "ChatViewController"
        static let ChatContactsViewController = "ChatContactsViewController"
        static let PatientDataViewController = "PatientDataViewController"
        static let ChatThreadVC = "ChatThreadVC"
        static let PlayerViewController = "player"
    }
    struct CELL {
        static let CompletedGoalTableViewCell = "CompletedGoalTableViewCell"
        static let CurrentGoalTableViewCell = "CurrentGoalTableViewCell"
        static let MindfulnessTableViewCell = "MindfulnessTableViewCell"
        static let QuestionTableViewCell = "QuestionTableViewCell"
        static let DisorderAnxietyTableViewCell = "DisorderAnxietyTableViewCell"
        static let ProfileTableViewCell = "ProfileTableViewCell"
        static let UsageStatisticsTableViewCell = "UsageStatisticsTableViewCell"
        static let UsageStatisticsDetailsTableViewCell = "UsageStatisticsTableViewCell"
        static let PatientGoalTableViewCell = "PatientGoalTableViewCell"
        static let AptTableViewCell = "AptTableViewCell"
        static let ConfirmAptViewController = "ConfirmAptViewController"
        static let InformationViewTableViewCell = "InformationViewTableViewCell"
        static let MoreInformationTableViewCell = "MoreInformationTableViewCell"
        static let cell = "cell"
        
    }
    
    struct SPACE {
        static let space = ""
    }
    
    struct COREDATA {
        struct  ENTITY {
            static let GoalData = "GoalData"
            static let ReminderData = "ReminderData"
        }
        struct KEY {
            static let currentgoals = "currentgoals"
            static let completedgoals = "completedgoals"
            static let reminderData = "reminderData"
        }
    }
    struct DATEFORMAT {
        static let MM_dd_yy = "MM/dd/yy"
        static let MM_dd_yyyy = "MM-dd-YYYY"
        static let HH_mm_ss_a = "HH:mm:ss a"
        static let YY_MMM_D_HH_mm =  "YY, MMM d, hh:mm"
        static let hh_mm_a = "hh:mm a"
        static let MM_dd = "MM/dd"
    }
    
    struct APPNAME {
        static let CollaborativeCare = "ACT"
    }
    
    struct URL {
        static let _478_Breathing_Exercise = "https://firebasestorage.googleapis.com/v0/b/collaborative-care-b5947.appspot.com/o/meditations%2Fbreathing.mp4?alt=media&token=0a5a6384-23a0-457e-b611-920a9c2f9940"
        static let calming_10 = "https://firebasestorage.googleapis.com/v0/b/collaborative-care-b5947.appspot.com/o/meditations%2Fmed5.mp3?alt=media&token=c287285e-fd1e-46fa-a96b-051db9cf694b"
        static let _10_minute_Body = "https://firebasestorage.googleapis.com/v0/b/collaborative-care-b5947.appspot.com/o/meditations%2Fmed3.mp3?alt=media&token=62160aef-596f-46e0-ba19-5d80c0277e97"
        static let _5_minute_Body = "https://firebasestorage.googleapis.com/v0/b/collaborative-care-b5947.appspot.com/o/meditations%2Fmed2.mp3?alt=media&token=3cbbc667-db00-40f1-a4d1-7bbd55b7f05b"
        static let _3_Minute_Breath = "https://firebasestorage.googleapis.com/v0/b/collaborative-care-b5947.appspot.com/o/meditations%2Fmed1.mp3?alt=media&token=d40e8dd6-23c7-467e-bf50-332a49381716"
        static let simply_listening = "https://firebasestorage.googleapis.com/v0/b/collaborative-care-b5947.appspot.com/o/meditations%2Fmed6.mp3?alt=media&token=7bf3bd5c-2b98-4e94-a2a5-3c5955ab092c"
        static let sitting_med = "https://firebasestorage.googleapis.com/v0/b/collaborative-care-b5947.appspot.com/o/meditations%2Fmed7.mp3?alt=media&token=aa27557d-5563-4782-a62c-6f206d0ec7c2"
        static let sleep_med = "https://firebasestorage.googleapis.com/v0/b/collaborative-care-b5947.appspot.com/o/meditations%2Fmed8.mp3?alt=media&token=efa46a0b-0efb-45ee-8ec4-b925197d919e"
        static let walking_med = "https://firebasestorage.googleapis.com/v0/b/collaborative-care-b5947.appspot.com/o/meditations%2Fmed9.mp3?alt=media&token=610071c9-4ede-442c-afa1-aafff3507c04"
        static let mindful = "https://firebasestorage.googleapis.com/v0/b/collaborative-care-b5947.appspot.com/o/meditations%2Fmed4.mp3?alt=media&token=fb275dcb-6aea-41a2-a236-eeba72b6ebad"
        
    }
    
    struct MED_ALBUM {
        static let Meditation = "Meditation"
        static let Simply_Listening_For_Grounding = "Simply Listening For Grounding"
        static let breathing_space = "Breathing Space"
        static let body_scan = "Body Scan"
    }
    
    struct MED_IMAGE {
        static let northen_lights = "northen_lights.jpg"
        static let dubai = "dubai.jpg"
        static let flower = "flower.jpg"
        static let passge_river = "passge_river.jpg"
        static let sunflower = "sunflower.jpg"
        static let waterfall = "waterfall.jpg"
        static let alberta = "alberta.jpg"
        static let tree_cloud = "tree_cloud.jpg"
        static let beach_chair = "beach_chair.jpg"
    }
    
    struct MESSAGE {
        static let appForToday = "Appointments for today"
        static let APPFor = "Appointments for "
        static let smilyface = "This meditation was recommended because it seems like you are feeling stressed today. This meditation may provide strategies to manage your feelings, thoughts, and stress."
        static let sickface = "This meditation was recommended because you seem to be feeling under the weather today. This meditation may provide strategies to manage your feelings, thoughts, and stress."
        static let sleepingman = "This meditation was recommended because it seems like you haven’t been sleeping well and may have poor sleep quality. It is recommended that you listen to this meditation before you go to sleep at night to quiet your mind, relax you and prepare your body for" + "\n" + "rest."
        static let standingman = "This meditation was recommended because you indicated that you haven’t been engaging in activities you enjoy lately. This meditation may help ground you and think about the activities you enjoy and pursue them."
        static let twoman = "This meditation was recommended because it seems like your social relationships haven’t been supportive or rewarding. This exercise may help you to manage your stress and change your perspectives."
        static let disclaimer_message = "By accepting the terms of this agreement, the user accepts all responsibility for the usage of this app, and acknowledges that they hold the University harmless for any claims arising from their use of the app. "
        static let aptReminder = "You have a appointment with "
        static let in_minutes = " in 5 minutes"
        static let internet_reachability = "The Internet connection appears to be offline."
        static let already_submitted = "You have already submitted your response for Daily Check-In."
        static let select_one_theme = "Please Choose One Theme"
        static let registered_successfully = "You are registered Successfully"
        static let enter_medicine_name = "Please enter your medicine name"
        static let enter_start_date = "Please enter start date"
        static let enter_end_date = "Please enter end date"
        static let choose_one_option = "Please Choose One Option"
        static let choose_medicine_time = "Please Choose Your Medicine Time"
        static let choose_dosage = "Please Choose Dosage for all medicines"
        static let choose_secondDose_medicine_time = "Please Choose Your Medicine Time For Second Dose"
        static let choose_thirdDose_medicine_time = "Please Choose Your Medicine Time For Third Dose"
        static let choose_days_in_week = "Please Choose a days in week"
        static let choose_how_often_week = "Please Choose How often do yu take medicine in week"
        static let choose_your_day = "Please Choose Your day for medicine"
        static let choose_two_days = "Please Choose two days for medicine"
        static let choose_three_days = "Please Choose three days for medicine"
        static let reminder_message = "It is time to take your medicine. Medicine name is "
        static let took_all_medication = "I took all of my medication"
        static let did_not_take_medication = "I did not take any of my medication"
        static let some_medication = "I took some of my medication"
        static let fill_all_answer = "Please Fill all Answer"
        static let response_submitted = "Your Response Successfully Submitted."
        static let visit_mindfulness = "Please visit the mindfulness page to see if you have any activity recommendations based on your response."
        static let important_medicines = "It is important to take your medication as prescribed by your doctor. If you have any questions or concerns about your medication, please contact your Behavioral Health Care Manager using the chat feature."
        static let validPassword = "Please enter valid provider password"
        // static let reminder_message = "Your medicine time in 5 minutes, medicine name is "
    }
    
    struct BTN_NAME {
        static let Change_Goal = "Change Goal"
        static let visit = "Visit"
    }
    
    struct FONT {
        static let FUTURABOOK = "FuturaPT-Book"
        static let FUTURABOLD = "FuturaPT-Bold"
        static let FUTURAMEDIUM = "FuturaPT-Medium"
        static let HELVETICALBOLD = "Helvetica-Bold"
        static let HELVETICA = "Helvetica"
    }
    
    struct CRYPTO {
        static let key = "bbC2H19lkVbQDfakxcrtNMQdd0FloLyw"
        static let iv = "gqLOHUioQ0QjhuvI"
    }
    
    struct MEDITATION {
        static let Calming_10_Minute_Breathing_Meditation = "Calming 10 Minute Breathing Meditation"
        static let _10_Minute_Body_Scan = "10 Minute Body Scan"
        static let _5_Minute_Body_Scan = "5 Minute Body Scan"
        static let _3_Minute_Breathing_Space = "3 Minute Breathing Space"
        static let Simply_Listening_for_Grounding = "Simply Listening For Grounding"
        static let Sitting_Meditation = "Sitting Meditation"
        static let Sleep_Meditation = "Sleep Meditation"
        static let Walking_Meditation = "Walking Meditation"
        static let Mindful_Movement = "Mindful Movement"
    }
    
    struct MOOD_REACTIONI_MG {
        static let smile = "smile1"
        static let sick = "sick1"
        static let hospital = "hospital1"
        static let man = "man1"
        static let twoman = "twoman1"
    }
    
    struct BUTTONTITLE {
        static let btnPasswordProtected = "Group 438"
        static let btnPasswordNotProtected = "Group 439"
        static let BtnDone  = "Done"
        static let BtnCancle  = "Cancel"
        static let BtnRadioCheck = "iconRadioCheck"
        static let BtnRadioUncheck = "icon-radio-UNcheck"
        static let BtnOpenDropDown = "Group 32"
        static let BtnCloseDropDown = "group321"
    }
    struct DateTime {
        static let DateFormat = "dd/MM/yyyy"
        
    }
    
    struct DAYS  {
        static let MONDAY = "Monday"
        static let TUESDAY = "Tuesay"
        static let WENESDAY = "Wednesday"
        static let THURSDAY = "Thursday"
        static let FRIDAY = "Friday"
        static let SATURDAY = "Saturday"
        static let SUNDAY = "Sunday"
    }
    struct CheckBtnTitle{
        static let Once_a_Week = "Once a Week"
        static let Two_days_a_Week = "Two days a Week"
        static let Three_days_a_Week = "Three days a Week"
    }
}
class NavigationHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    func setupView() {
        if themeFlag == 1 {
            backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.8745098039, blue: 0.8588235294, alpha: 1)
            themeColor = #colorLiteral(red: 0.6980392157, green: 0.8745098039, blue: 0.8588235294, alpha: 1)
        } else if themeFlag == 2 {
            backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.7450980392, blue: 0.9058823529, alpha: 1)
            themeColor = #colorLiteral(red: 0.8823529412, green: 0.7450980392, blue: 0.9058823529, alpha: 1)
        } else if themeFlag == 3 {
            backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
            themeColor = #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
        }
    }
    
    static func updateView(view: NavigationHeaderView) {
        if themeFlag == 1 {
            view.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.8745098039, blue: 0.8588235294, alpha: 1)
        } else if themeFlag == 2 {
            view.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.7450980392, blue: 0.9058823529, alpha: 1)
            
        } else if themeFlag == 3 {
            view.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
            
        }
    }
}

func returnThemeColor() -> UIColor {
    if themeFlag == 1 {
        return #colorLiteral(red: 0.5098039216, green: 0.6784313725, blue: 0.662745098, alpha: 1)
    } else if themeFlag == 2 {
        return  #colorLiteral(red: 0.6862745098, green: 0.5568627451, blue: 0.7098039216, alpha: 1)
    } else {
        return #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
    }
}

class SegmentedLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = themeColor
    }
    
    static func updateView(view: SegmentedLabel) {
        view.backgroundColor = themeColor
    }
}

class  UserDefineBtn: UIButton {
    static var color = UIColor()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    func setupView() {
        if themeFlag == 1 {
            backgroundColor = #colorLiteral(red: 0.5098039216, green: 0.6784313725, blue: 0.662745098, alpha: 1)
        } else if themeFlag == 2 {
            backgroundColor = #colorLiteral(red: 0.6862745098, green: 0.5568627451, blue: 0.7098039216, alpha: 1)
            
        } else if themeFlag == 3 {
            backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
            
        }
        UserDefineBtn.color = themeColor!
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
    }
    static func updateView(view: UserDefineBtn) {
        if themeFlag == 1 {
            view.backgroundColor = #colorLiteral(red: 0.5098039216, green: 0.6784313725, blue: 0.662745098, alpha: 1)
        } else if themeFlag == 2 {
            view.backgroundColor = #colorLiteral(red: 0.6862745098, green: 0.5568627451, blue: 0.7098039216, alpha: 1)
            
        } else if themeFlag == 3 {
            view.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
            
        }
    }
}

public func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
        
    }))
    let viewController: UIViewController = (UIApplication.shared.delegate?.window!!.rootViewController)!
    viewController.present(alertController, animated: true, completion: nil)
}

public func showAlertWithActions(title: String, secBtnTitle: String, message: String, accept: (() -> Void)? = nil, reject: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { sender in
        reject?()
    }))
    alert.addAction(UIAlertAction(title: secBtnTitle, style: .cancel, handler: { sender in
        accept?()
    }))
    let viewController: UIViewController = (UIApplication.shared.delegate?.window!!.rootViewController)!
    viewController.present(alert, animated: true, completion: completion)
}

func currentDateOnlyTime() -> Date {
    let stripDate =  Date().zeroSeconds!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
    let strCurrDate = dateFormatter.string(from: stripDate)
    let pDate = "0002-01-01T" + strCurrDate.components(separatedBy: " ")[1] + "+0000"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.date(from:pDate)!
}

func storeQueAnsArr(arr: [Int:[Int]]) {
    UserDefaults.standard.set(object: arr, forKey: KEY.USERDEFAULT.dailyQues)
}

func getQueAnsArr() -> [Int:[Int]]{
    if UserDefaults.standard.object(forKey:  KEY.USERDEFAULT.dailyQues) != nil {
        return UserDefaults.standard.object([Int: [Int]].self, with: KEY.USERDEFAULT.dailyQues)!
    } else {
        return [Int:[Int]]()
    }
    
}

func storeAptArr(arr: [Appointment]) {
    let userDefaults = UserDefaults.standard
    do {
        let encodedColor: Data =  try NSKeyedArchiver.archivedData(withRootObject: arr, requiringSecureCoding: false)
        userDefaults.set(encodedColor, forKey: KEY.USERDEFAULT.aptArr)
        userDefaults.synchronize()
    } catch {
    }
}

func getAptArr() -> [Appointment]{
    if UserDefaults.standard.object(forKey: KEY.USERDEFAULT.aptArr) != nil {
        do {
            let userDefaults = UserDefaults.standard
            let decoded  = userDefaults.data(forKey: KEY.USERDEFAULT.aptArr)
            let configData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as? [Appointment]
            return configData!
            
        } catch {
        }
    } else {
        return [Appointment]()
    }
    return [Appointment]()
}




//var questionnerAns = [Int]()
var themeColor: UIColor? = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
var medReminder = Reminder()
var pageReminder = 0
var reminderTrack = ReminderTrack()
var reminderdates: [Date] = []
var reminderString: [String] = []
var allReminders = [Reminder]()
var appDelegate = UIApplication.shared.delegate as? AppDelegate
extension UIViewController {
    func moveToNextScreen(iPhoneStoryboad: String, nextVC: String) {
        let storyboard = UIStoryboard(name: iPhoneStoryboad, bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: nextVC)
        self.navigationController?.pushViewController(initialViewController, animated: true)
    }
    func moveTobackScreen() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    func saveFromChatSDK() {
        let cvc = CurrentUser()
        if BChatSDK.currentUser() != nil {
            cvc.username = BChatSDK.currentUser().name()
            cvc.email = BChatSDK.currentUser().email()
            cvc.profileURL = BChatSDK.currentUser().imageURL()
            if userIndex == 0 {
                cvc.userType = "PROVIDER"
            } else {
                cvc.userType = "PATIENT"
            }
            storeUserInUserDefault(cvc: cvc)
        }
    }
}

extension Date {
    
    var zeroSeconds: Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calendar.date(from: dateComponents)
    }
    
}

public extension NSMutableAttributedString {
    func bold(_ value: String, fontSize: CGFloat, fonType: String, fontColor: UIColor = .clear) -> NSMutableAttributedString {
        var fontSize: CGFloat { return fontSize }
        var boldFont: UIFont { return UIFont(name: fonType, size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont,
            .foregroundColor: (fontColor != .clear ? fontColor : UIColor.black)
        ]
        
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func normal(_ value: String, fontSize: CGFloat, fonType: String) -> NSMutableAttributedString {
        var fontSize: CGFloat { return fontSize }
        var normalFont: UIFont { return UIFont(name: fonType, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
        let attributes: [NSAttributedString.Key: Any] = [
            .font: normalFont
        ]
        
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value: String, fontSize: CGFloat, fonType: String ) -> NSMutableAttributedString {
        var fontSize: CGFloat { return fontSize }
        var normalFont: UIFont { return UIFont(name: fonType, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func blackHighlight(_ value: String, fontSize: CGFloat, fonType: String) -> NSMutableAttributedString {
        var fontSize: CGFloat { return fontSize }
        var normalFont: UIFont { return UIFont(name: fonType, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.black
            
        ]
        
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func underlined(_ value: String, fontSize: CGFloat, fonType: String) -> NSMutableAttributedString {
        var fontSize: CGFloat { return fontSize }
        var normalFont: UIFont { return UIFont(name: fonType, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: normalFont,
            .underlineStyle: NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}

func changeTabBarTint() {
    if themeFlag == 1 {
        varTabBarController.tabBar.backgroundColor = #colorLiteral(red: 0.5098039216, green: 0.6784313725, blue: 0.662745098, alpha: 1)
    } else if themeFlag == 2 {
        varTabBarController.tabBar.backgroundColor = #colorLiteral(red: 0.6862745098, green: 0.5568627451, blue: 0.7098039216, alpha: 1)
    } else {
        varTabBarController.tabBar.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
    }
}

var durationGlobal: String?
var frequencyGlobal: String?
var startDate: String?

var themeFlag = 0
func changeBackground(view:UIView) {
    changeTabBarTint()
    if themeFlag == 1 {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "green_gradient.png")!)
    } else if themeFlag == 3 {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "blue_gradient.png")!)
    } else if themeFlag == 2 {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "pink_gradient.png")!)
    }
    else {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "pink_gradient.png")!)
    }
}

func returnLightThemeColor() -> UIColor {
    if themeFlag == 1 {
        return #colorLiteral(red: 0.6980392157, green: 0.8745098039, blue: 0.8588235294, alpha: 1)
    } else if themeFlag == 2 {
        return  #colorLiteral(red: 0.8823529412, green: 0.7450980392, blue: 0.9058823529, alpha: 1)
    } else {
        return #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
    }
}


func retriveEmail() -> (String) {
    if UserDefaults.standard.object(forKey: KEY.USERDEFAULT.email) != nil {
        do {
            let userDefaults = UserDefaults.standard
            let decoded  = userDefaults.data(forKey: KEY.USERDEFAULT.email)
            let configData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as? String
            return configData!
            
        } catch {
        }
    } else {
        return ""
    }
    return ""
}

func retriveGoalId() -> (Int) {
    if UserDefaults.standard.object(forKey: KEY.USERDEFAULT.goalId) != nil {
        do {
            let userDefaults = UserDefaults.standard
            let decoded  = userDefaults.data(forKey: KEY.USERDEFAULT.goalId)
            let configData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as? Int
            return configData!
            
        } catch {
        }
    } else {
        return -1
    }
    return -1
}


func retriveThemeFlag() -> (Int) {
    if UserDefaults.standard.object(forKey: KEY.USERDEFAULT.themeFlag) != nil {
        do {
            let userDefaults = UserDefaults.standard
            let decoded  = userDefaults.data(forKey: KEY.USERDEFAULT.themeFlag)
            let configData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as? Int
            return configData!
            
        } catch {
        }
    } else {
        return Int()
    }
    return Int()
}

func storeTheme() {
    let userDefaults = UserDefaults.standard
    do {
        let encodedColor: Data =  try NSKeyedArchiver.archivedData(withRootObject: themeFlag, requiringSecureCoding: false)
        userDefaults.set(encodedColor, forKey: KEY.USERDEFAULT.themeFlag)
        userDefaults.synchronize()
    } catch {
    }
}

func storeEmail(email: String) {
    let userDefaults = UserDefaults.standard
    do {
        let encodedColor: Data =  try NSKeyedArchiver.archivedData(withRootObject: email, requiringSecureCoding: false)
        userDefaults.set(encodedColor, forKey: KEY.USERDEFAULT.email)
        userDefaults.synchronize()
    } catch {
    }
}

func storeGoalId(id: Int) {
    let userDefaults = UserDefaults.standard
    do {
        let encodedColor: Data =  try NSKeyedArchiver.archivedData(withRootObject: id, requiringSecureCoding: false)
        userDefaults.set(encodedColor, forKey: KEY.USERDEFAULT.goalId)
        userDefaults.synchronize()
    } catch {
    }
}


func setupViewAfterLogout(){
    let window: UIWindow?
    let storyboard: UIStoryboard!
    let story = UIStoryboard(name: "Authentication", bundle:nil)
    let vc = story.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    let navigationController = UINavigationController(rootViewController: vc)
    UIApplication.shared.windows.first?.rootViewController = navigationController
    UIApplication.shared.windows.first?.makeKeyAndVisible()
}

func storeInMemory(){
//    let userDefaults = UserDefaults.standard
//    userDefaults.set(reminderString, forKey: "reminderString")
//    userDefaults.set(reminderdates, forKey: "reminderdates")
}
var loginFlag = false
var username = ""

func storeUserInUserDefault(cvc:CurrentUser) {
    let userDefaults = UserDefaults.standard
    do {
        let encodedColor: Data =  try NSKeyedArchiver.archivedData(withRootObject: cvc, requiringSecureCoding: false)
        userDefaults.set(encodedColor, forKey: KEY.USERDEFAULT.currentUser)
        userDefaults.synchronize()
    } catch {
    }
}

func retriveCurrentUser() -> (CurrentUser) {
    if UserDefaults.standard.object(forKey: KEY.USERDEFAULT.currentUser) != nil {
        do {
            let userDefaults = UserDefaults.standard
            let decoded  = userDefaults.data(forKey: KEY.USERDEFAULT.currentUser)
            let configData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as? CurrentUser
            return configData!
            
        } catch {
        }
    } else {
        return CurrentUser()
    }
    return CurrentUser()
}
var threadUserProfile: String?
var threadChat: PThread?
var threadUserName: String?
var varTabBarController = UITabBarController()
var goalIdentifier = 0
class InsetLabel: UILabel {
    
    let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.width += inset.left + inset.right
        intrinsicContentSize.height += inset.top + inset.bottom
        return intrinsicContentSize
    }
    
}

@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }
    
}

public func removeTimeStamp(fromDate: Date) -> Date {
    guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) else {
        fatalError("Failed to strip time from Date object")
    }
    return date
}

var userIndex: Int?
var splashVC: UINavigationController?
var lVC: LoginVC?
let db = Firestore.firestore()
var meditationInfo = Info()

func updateAndSetMeditationInDB(endTime: Int, startTime: Int, meditationTitle: String, meditationId: Int){
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-YYYY"
    let strDate = dateFormatter.string(from: date)
    // let updated = false
    
    let docRef = db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("usageStatistics").document(strDate)
    docRef.getDocument { (document, error) in
        if document!.exists {
            var count = 0
            var modulesData = [[String:Any]]()
            var info = [[String:Any]]()
            info.append(["endTime": endTime, "startTime": startTime, "timeProgress": endTime - startTime])
            let objects = document!.data()
            let modules = objects!["modules"] as! [[String:Any]]
            for module in modules {
                if module["meditationId"] as! Int == meditationId {
                    for mod in module["info"] as! [[String:Any]] {
                        info.append(mod)
                    }
                    count = module["count"] as! Int + 1
                }
            }
            if count == 0 {
                count = 1
            }
            for module in modules {
                if module["meditationId"] as! Int != meditationId {
                    modulesData.append(module)
                }
            }
            var data = [String:Any]()
            data["date"] = strDate
            var module = [String: Any]()
            module["count"] = count
            module["info"] = info
            module["meditationTitle"] = meditationTitle
            module["meditationId"] = meditationId
            modulesData.append(module)
            data["modules"] = modulesData
            db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("usageStatistics").document(strDate).updateData(data)
            
        } else {
            var data = [String:Any]()
            data["date"] = strDate
            var modulesData = [[String:Any]]()
            var module = [String: Any]()
            module["count"] = 1
            module["info"] = [["endTime": endTime, "startTime": startTime, "timeProgress": endTime - startTime]]
            module["meditationTitle"] = meditationTitle
            module["meditationId"] = meditationId
            modulesData.append(module)
            data["modules"] = modulesData
            db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("usageStatistics").document(strDate).setData(data)
            
        }
        
    }
}

var tempPatientData: PUser?
var appointments = [Appointment]()
var modifiedApt:Appointment?
var tasks: [Task] = []

extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}

func addTask(givenDate: Date, message: String, daily: String =  "") {
    var task: Task
    task = Task(context: context)
    let dateFormatters = DateFormatter()
    dateFormatters.dateFormat = "YY, MMM d, hh:mm"
    task.name = message + dateFormatters.string(from: givenDate)
    let time = givenDate
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
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
    scheduleNotification(taskName: message, taskDate: givenDate, daily: daily,inSeconds: timeInterval, completion: {success in
        if success{
            print(timeInterval)
        } else {
    
        }
    })
    let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
}

func scheduleNotification(taskName: String, taskDate: Date, daily: String = "", inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
    UNUserNotificationCenter.current().getPendingNotificationRequests { po in
        print(po)
    }
    let notif = UNMutableNotificationContent()
    notif.title = "Reminder"
    notif.body = taskName
    notif.sound = UNNotificationSound.default
    let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
    let request = UNNotificationRequest(identifier: daily.contains("Daily") ? String(taskDate.millisecondsSince1970) + daily : String(taskDate.millisecondsSince1970), content: notif, trigger: notifTrigger)

    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
        if error != nil {
            print(error)
            completion(false)
        } else {
            completion(true)
        }
    })

}

public enum Model : String {

//Simulator
case simulator     = "simulator/sandbox",

//iPod
iPod1              = "iPod 1",
iPod2              = "iPod 2",
iPod3              = "iPod 3",
iPod4              = "iPod 4",
iPod5              = "iPod 5",
iPod6              = "iPod 6",
iPod7              = "iPod 7",

//iPad
iPad2              = "iPad 2",
iPad3              = "iPad 3",
iPad4              = "iPad 4",
iPadAir            = "iPad Air ",
iPadAir2           = "iPad Air 2",
iPadAir3           = "iPad Air 3",
iPadAir4           = "iPad Air 4",
iPad5              = "iPad 5", //iPad 2017
iPad6              = "iPad 6", //iPad 2018
iPad7              = "iPad 7", //iPad 2019
iPad8              = "iPad 8", //iPad 2020

//iPad Mini
iPadMini           = "iPad Mini",
iPadMini2          = "iPad Mini 2",
iPadMini3          = "iPad Mini 3",
iPadMini4          = "iPad Mini 4",
iPadMini5          = "iPad Mini 5",

//iPad Pro
iPadPro9_7         = "iPad Pro 9.7\"",
iPadPro10_5        = "iPad Pro 10.5\"",
iPadPro11          = "iPad Pro 11\"",
iPadPro2_11        = "iPad Pro 11\" 2nd gen",
iPadPro3_11        = "iPad Pro 11\" 3rd gen",
iPadPro12_9        = "iPad Pro 12.9\"",
iPadPro2_12_9      = "iPad Pro 2 12.9\"",
iPadPro3_12_9      = "iPad Pro 3 12.9\"",
iPadPro4_12_9      = "iPad Pro 4 12.9\"",
iPadPro5_12_9      = "iPad Pro 5 12.9\"",

//iPhone
iPhone4            = "iPhone 4",
iPhone4S           = "iPhone 4S",
iPhone5            = "iPhone 5",
iPhone5S           = "iPhone 5S",
iPhone5C           = "iPhone 5C",
iPhone6            = "iPhone 6",
iPhone6Plus        = "iPhone 6 Plus",
iPhone6S           = "iPhone 6S",
iPhone6SPlus       = "iPhone 6S Plus",
iPhoneSE           = "iPhone SE",
iPhone7            = "iPhone 7",
iPhone7Plus        = "iPhone 7 Plus",
iPhone8            = "iPhone 8",
iPhone8Plus        = "iPhone 8 Plus",
iPhoneX            = "iPhone X",
iPhoneXS           = "iPhone XS",
iPhoneXSMax        = "iPhone XS Max",
iPhoneXR           = "iPhone XR",
iPhone11           = "iPhone 11",
iPhone11Pro        = "iPhone 11 Pro",
iPhone11ProMax     = "iPhone 11 Pro Max",
iPhoneSE2          = "iPhone SE 2nd gen",
iPhone12Mini       = "iPhone 12 Mini",
iPhone12           = "iPhone 12",
iPhone12Pro        = "iPhone 12 Pro",
iPhone12ProMax     = "iPhone 12 Pro Max",

// Apple Watch
AppleWatch1         = "Apple Watch 1gen",
AppleWatchS1        = "Apple Watch Series 1",
AppleWatchS2        = "Apple Watch Series 2",
AppleWatchS3        = "Apple Watch Series 3",
AppleWatchS4        = "Apple Watch Series 4",
AppleWatchS5        = "Apple Watch Series 5",
AppleWatchSE        = "Apple Watch Special Edition",
AppleWatchS6        = "Apple Watch Series 6",

//Apple TV
AppleTV1           = "Apple TV 1gen",
AppleTV2           = "Apple TV 2gen",
AppleTV3           = "Apple TV 3gen",
AppleTV4           = "Apple TV 4gen",
AppleTV_4K         = "Apple TV 4K",
AppleTV2_4K        = "Apple TV 4K 2gen",

unrecognized       = "?unrecognized?"
}

// #-#-#-#-#-#-#-#-#-#-#-#-#
// MARK: UIDevice extensions
// #-#-#-#-#-#-#-#-#-#-#-#-#

public extension UIDevice {

var type: Model {
    var systemInfo = utsname()
    uname(&systemInfo)
    let modelCode = withUnsafePointer(to: &systemInfo.machine) {
        $0.withMemoryRebound(to: CChar.self, capacity: 1) {
            ptr in String.init(validatingUTF8: ptr)
        }
    }

    let modelMap : [String: Model] = [

        //Simulator
        "i386"      : .simulator,
        "x86_64"    : .simulator,

        //iPod
        "iPod1,1"   : .iPod1,
        "iPod2,1"   : .iPod2,
        "iPod3,1"   : .iPod3,
        "iPod4,1"   : .iPod4,
        "iPod5,1"   : .iPod5,
        "iPod7,1"   : .iPod6,
        "iPod9,1"   : .iPod7,

        //iPad
        "iPad2,1"   : .iPad2,
        "iPad2,2"   : .iPad2,
        "iPad2,3"   : .iPad2,
        "iPad2,4"   : .iPad2,
        "iPad3,1"   : .iPad3,
        "iPad3,2"   : .iPad3,
        "iPad3,3"   : .iPad3,
        "iPad3,4"   : .iPad4,
        "iPad3,5"   : .iPad4,
        "iPad3,6"   : .iPad4,
        "iPad6,11"  : .iPad5, //iPad 2017
        "iPad6,12"  : .iPad5,
        "iPad7,5"   : .iPad6, //iPad 2018
        "iPad7,6"   : .iPad6,
        "iPad7,11"  : .iPad7, //iPad 2019
        "iPad7,12"  : .iPad7,
        "iPad11,6"  : .iPad8, //iPad 2020
        "iPad11,7"  : .iPad8,

        //iPad Mini
        "iPad2,5"   : .iPadMini,
        "iPad2,6"   : .iPadMini,
        "iPad2,7"   : .iPadMini,
        "iPad4,4"   : .iPadMini2,
        "iPad4,5"   : .iPadMini2,
        "iPad4,6"   : .iPadMini2,
        "iPad4,7"   : .iPadMini3,
        "iPad4,8"   : .iPadMini3,
        "iPad4,9"   : .iPadMini3,
        "iPad5,1"   : .iPadMini4,
        "iPad5,2"   : .iPadMini4,
        "iPad11,1"  : .iPadMini5,
        "iPad11,2"  : .iPadMini5,

        //iPad Pro
        "iPad6,3"   : .iPadPro9_7,
        "iPad6,4"   : .iPadPro9_7,
        "iPad7,3"   : .iPadPro10_5,
        "iPad7,4"   : .iPadPro10_5,
        "iPad6,7"   : .iPadPro12_9,
        "iPad6,8"   : .iPadPro12_9,
        "iPad7,1"   : .iPadPro2_12_9,
        "iPad7,2"   : .iPadPro2_12_9,
        "iPad8,1"   : .iPadPro11,
        "iPad8,2"   : .iPadPro11,
        "iPad8,3"   : .iPadPro11,
        "iPad8,4"   : .iPadPro11,
        "iPad8,9"   : .iPadPro2_11,
        "iPad8,10"  : .iPadPro2_11,
        "iPad13,4"  : .iPadPro3_11,
        "iPad13,5"  : .iPadPro3_11,
        "iPad13,6"  : .iPadPro3_11,
        "iPad13,7"  : .iPadPro3_11,
        "iPad8,5"   : .iPadPro3_12_9,
        "iPad8,6"   : .iPadPro3_12_9,
        "iPad8,7"   : .iPadPro3_12_9,
        "iPad8,8"   : .iPadPro3_12_9,
        "iPad8,11"  : .iPadPro4_12_9,
        "iPad8,12"  : .iPadPro4_12_9,
        "iPad13,8"  : .iPadPro5_12_9,
        "iPad13,9"  : .iPadPro5_12_9,
        "iPad13,10" : .iPadPro5_12_9,
        "iPad13,11" : .iPadPro5_12_9,

        //iPad Air
        "iPad4,1"   : .iPadAir,
        "iPad4,2"   : .iPadAir,
        "iPad4,3"   : .iPadAir,
        "iPad5,3"   : .iPadAir2,
        "iPad5,4"   : .iPadAir2,
        "iPad11,3"  : .iPadAir3,
        "iPad11,4"  : .iPadAir3,
        "iPad13,1"  : .iPadAir4,
        "iPad13,2"  : .iPadAir4,
        

        //iPhone
        "iPhone3,1" : .iPhone4,
        "iPhone3,2" : .iPhone4,
        "iPhone3,3" : .iPhone4,
        "iPhone4,1" : .iPhone4S,
        "iPhone5,1" : .iPhone5,
        "iPhone5,2" : .iPhone5,
        "iPhone5,3" : .iPhone5C,
        "iPhone5,4" : .iPhone5C,
        "iPhone6,1" : .iPhone5S,
        "iPhone6,2" : .iPhone5S,
        "iPhone7,1" : .iPhone6Plus,
        "iPhone7,2" : .iPhone6,
        "iPhone8,1" : .iPhone6S,
        "iPhone8,2" : .iPhone6SPlus,
        "iPhone8,4" : .iPhoneSE,
        "iPhone9,1" : .iPhone7,
        "iPhone9,3" : .iPhone7,
        "iPhone9,2" : .iPhone7Plus,
        "iPhone9,4" : .iPhone7Plus,
        "iPhone10,1" : .iPhone8,
        "iPhone10,4" : .iPhone8,
        "iPhone10,2" : .iPhone8Plus,
        "iPhone10,5" : .iPhone8Plus,
        "iPhone10,3" : .iPhoneX,
        "iPhone10,6" : .iPhoneX,
        "iPhone11,2" : .iPhoneXS,
        "iPhone11,4" : .iPhoneXSMax,
        "iPhone11,6" : .iPhoneXSMax,
        "iPhone11,8" : .iPhoneXR,
        "iPhone12,1" : .iPhone11,
        "iPhone12,3" : .iPhone11Pro,
        "iPhone12,5" : .iPhone11ProMax,
        "iPhone12,8" : .iPhoneSE2,
        "iPhone13,1" : .iPhone12Mini,
        "iPhone13,2" : .iPhone12,
        "iPhone13,3" : .iPhone12Pro,
        "iPhone13,4" : .iPhone12ProMax,
        
        // Apple Watch
        "Watch1,1" : .AppleWatch1,
        "Watch1,2" : .AppleWatch1,
        "Watch2,6" : .AppleWatchS1,
        "Watch2,7" : .AppleWatchS1,
        "Watch2,3" : .AppleWatchS2,
        "Watch2,4" : .AppleWatchS2,
        "Watch3,1" : .AppleWatchS3,
        "Watch3,2" : .AppleWatchS3,
        "Watch3,3" : .AppleWatchS3,
        "Watch3,4" : .AppleWatchS3,
        "Watch4,1" : .AppleWatchS4,
        "Watch4,2" : .AppleWatchS4,
        "Watch4,3" : .AppleWatchS4,
        "Watch4,4" : .AppleWatchS4,
        "Watch5,1" : .AppleWatchS5,
        "Watch5,2" : .AppleWatchS5,
        "Watch5,3" : .AppleWatchS5,
        "Watch5,4" : .AppleWatchS5,
        "Watch5,9" : .AppleWatchSE,
        "Watch5,10" : .AppleWatchSE,
        "Watch5,11" : .AppleWatchSE,
        "Watch5,12" : .AppleWatchSE,
        "Watch6,1" : .AppleWatchS6,
        "Watch6,2" : .AppleWatchS6,
        "Watch6,3" : .AppleWatchS6,
        "Watch6,4" : .AppleWatchS6,

        //Apple TV
        "AppleTV1,1" : .AppleTV1,
        "AppleTV2,1" : .AppleTV2,
        "AppleTV3,1" : .AppleTV3,
        "AppleTV3,2" : .AppleTV3,
        "AppleTV5,3" : .AppleTV4,
        "AppleTV6,2" : .AppleTV_4K,
        "AppleTV11,1" : .AppleTV2_4K
    ]

    guard let mcode = modelCode, let map = String(validatingUTF8: mcode), let model = modelMap[map] else { return Model.unrecognized }
    if model == .simulator {
        if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            if let simMap = String(validatingUTF8: simModelCode), let simModel = modelMap[simMap] {
                return simModel
            }
        }
    }
    return model
    }
}
