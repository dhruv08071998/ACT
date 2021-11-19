//
//  MedicineTableViewCell.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 6/6/21.
//

import UIKit

class MedicineTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMedicineName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
