//
//  PatientDataViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/26/21.
//
import UIKit
import ChatSDK
import SDWebImage
class PatientDataViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    @IBOutlet weak var patientTableView: UITableView!
    var usersData = [PUser]()
    var arrusersData = [PUser]()
    //var objFlag = Flag()
    var isChecked = [Bool]()
    var selectedIndex = -1
    var isEmpty = false
    var index = 0
    var searchText: String = ""
    @IBOutlet weak var txtSearchPatient: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated:true)
        txtSearchPatient.delegate = self
        loadDataFromDB()
        NotificationCenter.default
                          .addObserver(self,
                                       selector:#selector(slideLeft(_:)),
                         name: NSNotification.Name ("leftPatientDetails"),object: nil)
        NotificationCenter.default
                          .addObserver(self,
                                       selector:#selector(slideRight(_:)),
                         name: NSNotification.Name ("rightPatientDetails"),object: nil)
    }
    
    @objc func slideLeft(_ notification: Notification){
        if index != arrusersData.count - 1 {
            index += 1
            swipeThroughSlider()
        }
    }
    
    @objc func slideRight(_ notification: Notification){
        if index != 0 {
            index -= 1
            swipeThroughSlider()
        }
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHeaderView.updateView(view: viewNavigation)
        changeBackground(view: view)
        if tabBarController?.selectedIndex  == 1 {
            lblScreenName.text = "Select Patient"
            btnBack.isHidden = false
        } else if tabBarController?.selectedIndex  == 0 {
            lblScreenName.text = "Patient"
            btnBack.isHidden = true
        }
       // fromHome = 0
    }
    
    func loadDataFromDB() {
        BChatSDK.search().users(forIndexes: nil, withValue: "3534534535", limit: 20) { [self]  user in
            if user?.email() != BChatSDK.currentUser().email() && user?.userType() == "PATIENT" && user?.name() != nil{
                BChatSDK.core().observeUser(user?.entityID())
                usersData.append(user!)
                usersData = removeDuplicateElements(posts: usersData)
                arrusersData = usersData
                self.patientTableView.reloadData()
            }
        }
        
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        moveTobackScreen()
    }
    
    func removeDuplicateElements(posts: [PUser]) -> [PUser] {
        var uniquePosts = [PUser]()
        for post in posts {
            if !uniquePosts.contains(where: {$0.entityID() == post.entityID() }) {
                uniquePosts.append(post)
            }
        }
        return uniquePosts
    }
    
    @IBAction func btnClosedTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PatientDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrusersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PatientDataTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PatientDataTableViewCell") as? PatientDataTableViewCell)!
        cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.height/2
        cell.selectionStyle = .none
        cell.imgProfile.layer.borderWidth = 1
        cell.imgProfile.layer.borderColor = UIColor.black.cgColor
        cell.imgProfile.sd_setImage(with: URL(string:arrusersData[indexPath.row].imageURL()!), placeholderImage: UIImage(named: "user"))
        cell.lblProfileName.text = arrusersData[indexPath.row].name()!
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: PatientDataTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PatientDataTableViewCell") as? PatientDataTableViewCell)!
        tempPatientData = arrusersData[indexPath.row]
        if tabBarController?.selectedIndex == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmAptViewController") as! ConfirmAptViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        else if tabBarController?.selectedIndex == 0 {
            index = indexPath.row
            moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Provider, nextVC: "PatientDetailViewController")
        }
        
    }
    
    func swipeThroughSlider() {
        tempPatientData = arrusersData[index]
//        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Provider, nextVC: "PatientDetailViewController")
    }
    
}

extension PatientDataViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isEmpty = false
        if string.isEmpty {
            searchText = String(searchText.dropLast())
            if (txtSearchPatient.text?.dropLast().isEmpty)! {
                isEmpty = true
            }
        } else {
            searchText = (textField.text!+string)
        }
        arrusersData  = searchText.isEmpty ? usersData : usersData.filter({ (flag) -> Bool in
            return flag.name().range(of: searchText.trimmingTrailingSpaces, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        patientTableView.reloadData()
        return true
    }
    
}







//
