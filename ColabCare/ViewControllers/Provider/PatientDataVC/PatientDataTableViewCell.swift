//
//  CountryPickerTableViewCell.swift
//  ZollEnproAedlink
//
//  Created by Dhruv Upadhyay on 05/06/20.
//  Copyright © 2020 Devarshi Pandya. All rights reserved.
//

import UIKit

class PatientDataTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
