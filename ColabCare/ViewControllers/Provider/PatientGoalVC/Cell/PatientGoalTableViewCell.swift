//
//  PatientGoalTableViewCell.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 8/9/21.
//

import UIKit

class PatientGoalTableViewCell: UITableViewCell {

  
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var lblGoalNotes: UILabel!
    @IBOutlet weak var lblCompletedDate: UILabel!
    @IBOutlet weak var lblIntitalDate: UILabel!
    @IBOutlet weak var lblGoalTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
