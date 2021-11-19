//
//  HomeTableViewCell.swift
//  ColabCare
//
//  Created by Dhruv Upadhyay on 11/03/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMedicine: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
