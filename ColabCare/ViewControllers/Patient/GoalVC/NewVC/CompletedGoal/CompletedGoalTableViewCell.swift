//
//  CurrentGoalTableViewCell.swift
//  ColabCare
//
//  Created by Dhruv Upadhyay on 22/04/21.
//

import UIKit

class CompletedGoalTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDateCompletedBy: UILabel!
    @IBOutlet weak var btnSwap: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitleGoal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewContainer.setupShadow()
        lblNotes.adjustsFontSizeToFitWidth = true
        lblNotes.minimumScaleFactor = 0.5
        lblNotes.numberOfLines = 0
        viewContainer.layer.cornerRadius = 12
        viewContainer.layer.borderWidth = 2
        viewContainer.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        viewContainer.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)

        // Configure the view for the selected state
    }

}

