//
//  UsageStatisticsDetailsTableViewCell.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 8/9/21.
//

import UIKit

class UsageStatisticsDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
