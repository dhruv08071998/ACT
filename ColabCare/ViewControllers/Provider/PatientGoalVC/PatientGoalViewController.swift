//
//  PatientGoalViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 8/9/21.
//

import UIKit
import ChatSDK
class PatientGoalViewController: UIViewController {

    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    @IBOutlet weak var tblViewPatientGoal: UITableView!
    @IBOutlet weak var txtSearchGoal: UITextField!
    var patientData: PUser?
    var patientGoals = [Goal]()
    var copyPatientGoals = [Goal]()
    var isEmpty = false
    var toolBar = UIToolbar()
    var valueSelected = String()
    var datasource = [String]()
    var picker  = UIPickerView()
    var searchText: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewPatientGoal.delegate = self
        tblViewPatientGoal.dataSource = self
        picker.delegate = self
        picker.dataSource = self
        txtSearchGoal.delegate = self
        patientData = tempPatientData
        datasource = [KEY.PARAMETER.all, KEY.PARAMETER.Completed, KEY.PARAMETER.inProgress]

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHeaderView.updateView(view: viewNavigation)
        changeBackground(view: view)
        fetchPatientGoals { [self] flag in
            if flag!{
                copyPatientGoals = patientGoals
                tblViewPatientGoal.reloadData()
            }
        }
    }
    //MARK:- ACTION
    @IBAction func btnFilterTapped(_ sender: Any) {
        toolBar.sizeToFit()
            picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: KEY.PARAMETER.textColor)
            picker.autoresizingMask = .flexibleWidth
            picker.contentMode = .center
            picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
            self.view.addSubview(picker)
                    
            toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
            toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
            self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        filterData()
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        self.view.endEditing(true)
    }
    

    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        moveTobackScreen()
    }
    
    func fetchPatientGoals( completion: @escaping(Bool?) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            db.collection("user_data").document(patientData!.entityID()!).collection("goals").addSnapshotListener { [self]
                (querySnapshot, err) in
                patientGoals.removeAll()
                copyPatientGoals.removeAll()
                if let err = err
                {
                    print("Error getting documents: \(err)");
                    completion(false)
                }
                else
                {
                    for document in querySnapshot!.documents {
                        let obj = Goal()
                        obj.goalName = (document["goal_title"] as! String)
                        obj.notes = (document["goal_notes"] as! String)
                        obj.intialDate = (document["initial_date"] as! String)
                        obj.completedBy = (document["complete_date"] as! String)
                        obj.tag = (document["tag"] as! Bool)
                        patientGoals.append(obj)
                    }
                    completion(true)
                }
                
                
            }
        }else {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
            completion(false)
        }
    }
    
}

extension PatientGoalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return copyPatientGoals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PatientGoalTableViewCell = tableView.dequeueReusableCell(withIdentifier: KEY.CELL.PatientGoalTableViewCell) as! PatientGoalTableViewCell
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        cell.lblGoalTitle.text = copyPatientGoals[indexPath.row].goalName
        cell.lblGoalNotes.text = copyPatientGoals[indexPath.row].notes
        cell.lblIntitalDate.text = copyPatientGoals[indexPath.row].intialDate
        cell.lblCompletedDate.text = copyPatientGoals[indexPath.row].completedBy
        cell.btnStatus.isEnabled = false
        cell.viewBackground.layer.borderWidth = 1
        cell.viewBackground.layer.cornerRadius = 12
        cell.viewBackground.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if copyPatientGoals[indexPath.row].tag{
            cell.btnStatus.setImage(UIImage(named: "icon-radio-check"), for: .normal)
        } else {
            cell.btnStatus.setImage(UIImage(named: "icons8-in-progress-48"), for: .normal)
        }
        
        return cell
    }
    
    
}


extension PatientGoalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isEmpty = false
        if string.isEmpty {
            searchText = String(searchText.dropLast())
            if (txtSearchGoal.text?.dropLast().isEmpty)! {
                isEmpty = true
            }
        } else {
            searchText = (textField.text!+string)
        }
        copyPatientGoals  = searchText.isEmpty ? patientGoals : patientGoals.filter({ (flag) -> Bool in
            return flag.goalName.range(of: searchText.trimmingTrailingSpaces, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        tblViewPatientGoal.reloadData()
        return true
    }
    
    func filterData() {
        if valueSelected == KEY.PARAMETER.all {
            fetchPatientGoals { [self] flag in
                if flag! {
                    copyPatientGoals = patientGoals
                    tblViewPatientGoal.reloadData()
                }
            }
        } else if valueSelected == KEY.PARAMETER.Completed {
            fetchPatientGoals { [self] flag in
                if flag! {
                    copyPatientGoals = patientGoals
                    let tempGoals = patientGoals.filter { $0.tag == true }
                    patientGoals = tempGoals
                    copyPatientGoals = patientGoals
                    tblViewPatientGoal.reloadData()
                    tblViewPatientGoal.reloadData()
                }
            }
        } else if valueSelected == KEY.PARAMETER.inProgress {
            fetchPatientGoals { [self] flag in
                if flag! {
                    copyPatientGoals = patientGoals
                    let tempGoals = patientGoals.filter { $0.tag == false }
                    patientGoals = tempGoals
                    copyPatientGoals = patientGoals
                    tblViewPatientGoal.reloadData()
                    tblViewPatientGoal.reloadData()
                }
            }
        }
    }
    
}

extension PatientGoalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datasource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datasource[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         valueSelected = datasource[row] as String
    }
    
}

