//
//  AddGoalViewController.swift
//  ColabCare
//
//  Created by Dhruv Upadhyay on 22/04/21.
//

import UIKit
import FSCalendar
class AddGoalViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var btnAddGoal: UIButton!
    @IBOutlet weak var getDate: FSCalendar!
    @IBOutlet weak var txtNotes: PaddedTextField!
    @IBOutlet weak var txtTitleGoal: PaddedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNotes.delegate = self
        txtTitleGoal.delegate = self
        getDate.delegate = self
        getDate.dataSource = self
        if selectGoal != nil {
            txtNotes.text = selectGoal![KEY.PARAMETER.notes] as? String
            txtTitleGoal.text = selectGoal![KEY.PARAMETER.goalName] as? String
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = KEY.DATEFORMAT.MM_dd_yy
            let date = dateFormatter.date(from: (selectGoal![KEY.PARAMETER.completedBy] as? String)!) ?? Date()
            getDate.select(date)
            btnAddGoal.setTitle(KEY.BTN_NAME.Change_Goal, for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        selectGoal = nil
    }
    @IBAction func addGoalBtnTapped(_ sender: Any) {
        var date = ""
        if getDate.selectedDate != nil{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = KEY.DATEFORMAT.MM_dd_yy
            date = dateFormatter.string(from: getDate.selectedDate!)
        } else {
            date = Date.getCurrentDate()
        }
        var goalIdentifier: Int?
        if selectGoal == nil {
        goalIdentifier = retriveGoalId()
        if goalIdentifier == nil {
            goalIdentifier = 0
        }
            goalIdentifier! += 1
        } else {
            goalIdentifier = Int(selectGoal![KEY.PARAMETER.goalId] as! String)
        }
        storeGoalId(id: goalIdentifier!)
        selectGoal = [KEY.PARAMETER.goalName: txtTitleGoal.text!, KEY.PARAMETER.goalId: String(goalIdentifier!),  KEY.PARAMETER.notes: txtNotes.text!, KEY.PARAMETER.intialDate: Date().string(format: KEY.DATEFORMAT.MM_dd_yy), KEY.PARAMETER.completedBy: date]
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
extension AddGoalViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.2352941176, blue: 0.5254901961, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        textField.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.9882352941, alpha: 0.42)
    }
}

extension Date {
    
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: Date())
    }
}
