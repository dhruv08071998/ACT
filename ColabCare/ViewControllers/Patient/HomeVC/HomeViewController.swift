//
//  HomeViewController.swift
//  ColabCare
//
//  Created by Dhruv Upadhyay on 09/03/21.
//

import UIKit
import SwiftGifOrigin
import ChatSDK
import FirebaseFirestore
class HomeViewController: UIViewController {
    
    @IBOutlet weak var lblQuotes: InsetLabel!
    @IBOutlet weak var constraintImageHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var btnMedicationReminder: UIButton!
    @IBOutlet weak var viewSunrise: UIImageView!
    @IBOutlet weak var viewNaigation: NavigationHeaderView!
    var quotesArr = ["“Too often we underestimate the power of a touch, a smile, a kind word, a listening ear, an honest accomplishment, or the smallest act of caring, all of which have the potential to turn a life around.” –Leo Buscaglia", "“When one door of happiness closes, another opens; but often we look so long at the closed door that we do not see the one which has been opened for us.” ― Helen Keller", "Magic is believing in yourself. If you can make that happen, you can make anything happen” -Johann Wolfgang von Goethe", "“The hard days are what make you stronger.” –Aly Raisman", "“Keep your eyes on the stars, and your feet on the ground.” –Theodore Roosevelt", "“Don’t be pushed around by the fears in your mind. Be led by the dreams in your heart.” –Roy T. Bennett", "“You mustdo the thing you think you cannot do.” –Eleanor Roosevelt", "“Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going.” –Chantal Sutherland", "“You’re braver than you believe, and stronger than you seem, and smarter than you think.” -A.A. Mine", "“Every day may not be good... but there’s something good in every day.”-Alice Morse Earle", "“The more you praise and celebrate your life, the more there is in life to celebrate.” -Oprah Winfrey", "“The ability to be in the present moment is a major component of mental wellness.” -Abraham Maslow", "“Life is a great and wondrous mystery, and the only thing we know that we have for sure is what is right here right now. Don’t miss it.” –Leo Buscaglia", "You can't stop the waves, but you can learn to surf.”―Jon Kabat-Zinn", "Be thankful for what you have and you will end up havingmore. –Oprah Winfrey", "Beauty is everywhere. You only have to look to see it. –Bob Ross", "Sing like the birds sing, not worrying about who hears or what they think. –Rumi", "See what no one else sees. See what everyone chooses not to see –out of fear, conformity or laziness. See the whole world anew each day! –Patch Adams", "Shine like the whole universe is yours! –Rumi", "Life is a fairy tale. Live it with wonder and amazement. –Welwyn Wilton Katz" ]
    
    @IBOutlet weak var baseView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        intiateReminderProcess()
        saveFromChatSDK()
        updateThemeElements()
        btnMedicationReminder.backgroundColor = .clear
        UserDefineBtn.color = themeColor!
        navigationController?.setNavigationBarHidden(true, animated: true)
        scrollView?.showsVerticalScrollIndicator = false
        if UIDevice().type.rawValue == "iPhone 7" || UIDevice().type.rawValue == "iPhone 8" || UIDevice().type.rawValue == "iPhone 8 Plus" || UIDevice().type.rawValue == "iPhone 7 Plus" || UIDevice().type.rawValue == "iPhone SE (2nd generation)"  ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6S" ||  UIDevice().type.rawValue == "iPhone 6S Plus"{
            constraintImageHeight.constant = 170
        }
        lblQuotes.layer.cornerRadius = 10
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeUp.direction = .up
            self.view.addGestureRecognizer(swipeUp)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")
            case .up:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowRemindersViewController") as! ShowRemindersViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }
    
    @objc func changeQuotes() {
        UIView.transition(with: lblQuotes,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self!.selectQuotes()
                          }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        changeQuotes()
        if isBeingDismissed {
            saveFromChatSDK()
            lblUser.text = retriveCurrentUser().username!.contains("ChatSDK") ? "Hello" : " Hello " + retriveCurrentUser().username!
        }
    }
    
    
    func selectQuotes() {
        guard quotesArr.count > 0 else {
            return
        }
        
        let randomElement = quotesArr.randomElement()!
        lblQuotes.text = randomElement
    }
    
    func setFirstLogin() {
        if retriveEmail() == "" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "EditUserProfileViewController") as! EditUserProfileViewController
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
    
    @IBAction func btnMedicationReminderTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowRemindersViewController") as! ShowRemindersViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice().type.rawValue == "iPhone 7" || UIDevice().type.rawValue == "iPhone 8" ||  UIDevice().type.rawValue == "iPhone 7 Plus" ||  UIDevice().type.rawValue == "iPhone 8 Plus" ||  UIDevice().type.rawValue == "iPhone SE (2nd generation)" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6S" ||  UIDevice().type.rawValue == "iPhone 6S Plus"{
            lblQuotes.font = lblQuotes.font.withSize(20)
        }
        self.tabBarController?.tabBar.isHidden = false
        updateThemeElements()
        assignbackground()
        setFirstLogin()
        if NetworkReachabilityManager()!.isReachable {
        db.collection("user_data").document(BChatSDK.currentUser().entityID()).updateData(["email":BChatSDK.currentUser().email()!, "name":BChatSDK.currentUser().name()!, "phone":"" , "type": "PATIENT"])
        } else {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
        }
        if retriveCurrentUser().username != nil {
            lblUser.text =  retriveCurrentUser().username!.contains("ChatSDK") ? "Hello" :  "Hello, " + retriveCurrentUser().username! + "!"
        }
        else if BChatSDK.currentUser().name() != nil {
            lblUser.text = BChatSDK.currentUser().name().contains("ChatSDK") ? "Hello" : "Hello, " + BChatSDK.currentUser().name() + "!"
        }
    }
    
    func updateThemeElements(){
        changeBackground(view: self.baseView)
        NavigationHeaderView.updateView(view: viewNaigation)
        varTabBarController = self.tabBarController!
        if themeFlag == 1 {
            lblUser.textColor = #colorLiteral(red: 0.5098039216, green: 0.6784313725, blue: 0.662745098, alpha: 1)
            self.tabBarController!.tabBar.backgroundColor = #colorLiteral(red: 0.5098039216, green: 0.6784313725, blue: 0.662745098, alpha: 1)
        } else if themeFlag == 2 {
            lblUser.textColor = #colorLiteral(red: 0.6862745098, green: 0.5568627451, blue: 0.7098039216, alpha: 1)
            self.tabBarController!.tabBar.backgroundColor = #colorLiteral(red: 0.6862745098, green: 0.5568627451, blue: 0.7098039216, alpha: 1)
        } else {
            lblUser.textColor = #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
            self.tabBarController!.tabBar.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6, blue: 0.7764705882, alpha: 1)
        }
    }
    
    func assignbackground(){
        do {
            viewSunrise.image = UIImage.gif(name: "54102-sunrise-breathe-in-breathe-out")
            viewSunrise.contentMode = .scaleAspectFill
            let btnImage = UIImage.gif(name: "arrow")
            btnMedicationReminder.setImage(btnImage , for: .normal)
            btnMedicationReminder.contentMode = .center
            btnMedicationReminder.imageView?.contentMode = .scaleAspectFit
        } catch {
            print(error)
        }
    }
    
}
