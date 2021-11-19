//
//  InformationViewTableViewCell.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 8/6/21.
//

import UIKit

class InformationViewTableViewCell: UITableViewCell {

    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var imgInfoIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
