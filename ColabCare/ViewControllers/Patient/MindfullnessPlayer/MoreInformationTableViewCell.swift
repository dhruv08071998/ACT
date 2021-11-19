//
//  MoreInformationTableViewCell.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 6/18/21.
//

import UIKit

class MoreInformationTableViewCell: UITableViewCell {

    @IBOutlet weak var imageThubnail: UIImageView!
    
    @IBOutlet weak var btnMoreInformation: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageThubnail.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
