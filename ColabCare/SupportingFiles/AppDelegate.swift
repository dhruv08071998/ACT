//
//  AppDelegate.swift
//  Collab Care
//
//  Created by Anant Patni on 1/29/21.
//

import UIKit
import CoreData
import ChatSDK
import ChatSDKFirebase
import Firebase
import UserNotifications
import IQKeyboardManagerSwift
import AVFoundation
import FirebaseModules
import MessageModules
import EncryptionModule
@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        let modules = [
            FirebaseNetworkAdapterModule.shared(),
            FirebasePushModule.shared(),
            FirebaseUploadModule.shared(),
            EncryptionModule.init(),
            BLastOnlineModule.init(),
            BReadReceiptsModule.init(),
        ]
        //        BChatSDK.initialize(config, app: application, options: launchOptions, modules:modules)
        let config = BConfiguration.init();
        config.rootPath = "cc_1"
        // Configure other options here...
        config.allowUsersToCreatePublicChats = true
        BChatSDK.activateLicense(withEmail: "njaloisi@buffalo.edu")
        BChatSDK.initialize(config, app: application, options: launchOptions, modules: modules)
        Messaging.messaging().delegate = self
        notificationCenter.delegate = self
        if retriveThemeFlag() != 0 {
            themeFlag = retriveThemeFlag()
        } else {
            themeFlag = 1
            storeTheme()
        }
        let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            } catch let error as NSError {
                print("Setting category to AVAudioSessionCategoryPlayback failed: \(error)")
            }
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        application.registerForRemoteNotifications()
        
        let userDefaults = UserDefaults.standard
        if UserDefaults.standard.object(forKey: "reminderdates") != nil {
            reminderdates = userDefaults.object(forKey: "reminderdates") as! [Date]
        }
        if UserDefaults.standard.object(forKey: "reminderString") != nil {
            reminderString = userDefaults.object(forKey: "reminderString") as! [String]
        }
        let myVC = SplashVC()
        BChatSDK.ui().setSplashScreenViewController(myVC)
        let chatViewController = PrivateThreadVC()
        BChatSDK.ui().setPrivateThreadsViewController(chatViewController)
        let vc = ChatContactThread()
        BChatSDK.ui().setContactsViewController(vc)
        return true
    }
    

    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            print(token)
        }
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        BChatSDK.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        Messaging.messaging().apnsToken = deviceToken
     
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        BChatSDK.application(application, didReceiveRemoteNotification: userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        BChatSDK.application(application, didReceiveRemoteNotification: userInfo)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return BChatSDK.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return BChatSDK.application(app, open: url, options: options)
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ColabCare")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier.contains("Daily") {
            var date = notification.request.identifier.replacingOccurrences(of: "Daily", with: "")
            addNewDateForDaily(id: date, message: notification.request.content.body)
            let frequency = date.suffix(1)
            let repeatance = Float(frequency)
            let scheduledDate =   Date(milliseconds: Int64(date.dropLast())! + Int64(repeatance!*1440*60*1000))
            addTask(givenDate: scheduledDate, message: notification.request.content.body , daily: "Daily" + frequency)
        }
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        
        completionHandler()
    }
    
    static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
}

let ad = UIApplication.shared.delegate as! AppDelegate
let context = ad.persistentContainer.viewContext


func addNewDateForDaily(id: String, message:String) {
    let frequency = id.suffix(1) // getting repeatance of notification
    let repeatance = Float(frequency)
    let date = Date(milliseconds: Int64(id.dropLast())!)
    let medName =  message.replacingOccurrences(of: KEY.MESSAGE.reminder_message, with: "")
    var myReminders = UIViewController().retrieveDataReminder(key: KEY.COREDATA.KEY.reminderData)
    var remObj = Reminder()
    var index = Int()
    for rem in myReminders {
        if rem.medicineName == medName {
            if ((rem.arrDates?.contains(date)) != nil) {
                remObj = rem
                index = myReminders.firstIndex(of: rem)!
            }
        }
    }
     myReminders.remove(at: index)
    let myDate = Date(milliseconds: Int64(id.dropLast())! + Int64(repeatance!*1440*60*1000))
    remObj.arrDates = [myDate]
    let time = getTime(date: myDate)
    remObj.medicineTime = remObj.medicineTime?.filter { $0 != time }
    remObj.medicineTime?.append(time)
    myReminders.append(remObj)
    UIViewController().deleteAllData(entity: KEY.COREDATA.ENTITY.ReminderData)
    UIViewController().createDataReminder(data: myReminders, key: KEY.COREDATA.KEY.reminderData)
}

func getTime(date:Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a" // output format
    let string = dateFormatter.string(from: date)
    var firstChar = Array(string)[0]
    if firstChar == "0" {
        string.dropFirst()
    }
    return string
}
