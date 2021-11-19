//
//  MedicationReminderTableViewCell.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 6/2/21.
//

import UIKit

class MedicationReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var viewcontainerTopConstant: NSLayoutConstraint!
    @IBOutlet weak var lblIntialDate: UILabel!
    @IBOutlet weak var imgCalender: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblMedicineDuration: UILabel!
    @IBOutlet weak var lblMedicineTime: UILabel!
    @IBOutlet weak var lblMedicineName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.cornerRadius = 5
        viewContainer.layer.borderWidth = 1
        viewContainer.layer.borderColor = .black()
        viewContainer.layer.shadowColor = #colorLiteral(red: 0.9333333333, green: 0.937254902, blue: 0.9647058824, alpha: 1)
        viewContainer.layer.shadowOpacity = 0.8
        viewContainer.layer.shadowRadius = 2.0
        viewContainer.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
