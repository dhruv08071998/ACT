//
//  ViewController.swift
//  ColabCare
//
//  Created by Dhruv Upadhyay on 06/03/21.
//

import UIKit
import CoreData
import CryptoSwift
import ChatSDK

class CompletedGoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ModalTransitionListener {
    
    func popoverDismissed() {
        if editedGoal != nil {
            completedGoals[editedGoal!] = Goal(fromDictionary: selectGoal! as [String: Any])
            editedGoal = nil
        } else {
            completedGoals.append(Goal(fromDictionary: selectGoal! as [String: Any]))
        }
        selectGoal = nil
        storeData()
        self.tblViewCurrentGoal.reloadData()
    }
    
    var goals = [Goal]()
    @IBOutlet weak var tblViewCurrentGoal: UITableView!
    @IBOutlet weak var btnAddGoal: UIButton!
    var editedGoal: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackground(view: self.view)
        btnAddGoal.layer.cornerRadius = btnAddGoal.frame.height/2
        self.tabBarController?.tabBar.isHidden = false
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        ModalTransitionMediator.instance.setListener(listener: self)
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        tblViewCurrentGoal.reloadData()
        if UserDefineBtn.color != themeColor{
            changeBackground(view: self.view)
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                NotificationCenter.default.post(name: NSNotification.Name("right"),object: nil)
            default:
                break
            }
        }
    }
    
    @IBAction func btnAddGoalTapped(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedGoals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if NetworkReachabilityManager()!.isReachable {
            db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("goals").document(String(completedGoals[indexPath.row].goalId)).updateData(["complete_date": completedGoals[indexPath.row].completedBy.replaceDash(), "goal_notes": completedGoals[indexPath.row].notes, "goal_title": completedGoals[indexPath.row].goalName, "initial_date": completedGoals[indexPath.row].intialDate.replaceDash(), "tag": true])
        } else {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: KEY.CELL.CompletedGoalTableViewCell) as! CompletedGoalTableViewCell
        cell.lblDate.text = completedGoals[indexPath.row].intialDate
        cell.lblTitleGoal.text = completedGoals[indexPath.row].goalName
        cell.lblNotes.text = "Notes: " + completedGoals[indexPath.row].notes
        cell.lblDateCompletedBy.text = completedGoals[indexPath.row].completedBy
        cell.btnEdit.addTarget(self, action: #selector(btnEditTapped(_:)), for: .touchUpInside)
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.btnDelete.addTarget(self, action: #selector(btnDeleteTapped(_:)), for: .touchUpInside)
        cell.btnSwap.tag = indexPath.row
        cell.btnSwap.addTarget(self, action: #selector(btnSwapTapped(_:)), for: .touchUpInside)
        return cell
    }
    @IBAction func addGoalBtnTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddGoalViewController") as! AddGoalViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @objc func btnEditTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddGoalViewController") as! AddGoalViewController
        vc.modalPresentationStyle = .fullScreen
        selectGoal = completedGoals[sender.tag].toDictionary()
        editedGoal = sender.tag
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func btnDeleteTapped(_ sender: UIButton) {
        completedGoals.remove(at: sender.tag)
        tblViewCurrentGoal.reloadData()
        storeData()
    }
    
    @objc func btnSwapTapped(_ sender: UIButton) {
        db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("goals").document(String(completedGoals[sender.tag].goalId)).updateData(["complete_date": completedGoals[sender.tag].completedBy.replaceDash(), "goal_notes": completedGoals[sender.tag].notes!, "goal_title": completedGoals[sender.tag].goalName!, "initial_date": completedGoals[sender.tag].intialDate.replaceDash(), "tag": false])
        currentGoals.append(completedGoals[sender.tag])
        completedGoals.remove(at: sender.tag)
        storeData()
        tblViewCurrentGoal.reloadData()
    }
}

extension String {
    func aesEncrypt() throws -> String {
        let encrypted = try AES(key: KEY.CRYPTO.key, iv: KEY.CRYPTO.iv, padding: .pkcs7).encrypt([UInt8](self.data(using: .utf8)!))
        return Data(encrypted).base64EncodedString()
    }
    
    func aesDecrypt() throws -> String {
        guard let data = Data(base64Encoded: self) else { return "" }
        let decrypted = try AES(key: KEY.CRYPTO.key, iv: KEY.CRYPTO.iv, padding: .pkcs7).decrypt([UInt8](data))
        return String(bytes: decrypted, encoding: .utf8) ?? self
    }
}
