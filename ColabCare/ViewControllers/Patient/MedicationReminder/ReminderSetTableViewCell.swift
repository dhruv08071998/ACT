//
//  ReminderSetTableViewCell.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 6/4/21.
//

import UIKit

class ReminderSetTableViewCell: UITableViewCell {

    @IBOutlet weak var txtDosage: UITextField!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var txtTime: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        txtDosage.delegate = self
        txtTime.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        btnDelete.layer.cornerRadius = btnDelete.frame.height/2
        txtTime.layer.cornerRadius = 7
        txtTime.placeholder = "Select a time"
        txtDosage.layer.cornerRadius = 7
        txtDosage.placeholder = "Dosage(mg)"
    }

}

extension ReminderSetTableViewCell: UITextFieldDelegate {
   // NotificationCenter.default.post(name: NSNotification.Name("left"),object: nil)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtTime {
            return false
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtDosage {
            NotificationCenter.default.post(name: NSNotification.Name("enableScrollTableView"),object: nil)
        }
        return true
    }

}
