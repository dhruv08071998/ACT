//
//  ProfileTableViewCell.swift
//  ZollEnproAedlink
//
//  Created by Devarshi Pandya on 5/29/20.
//  Copyright © 2020 Devarshi Pandya. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    // MARK: - Property Declaration
    @IBOutlet var imgViewModule: UIImageView!
    @IBOutlet var lblModule: UILabel!
    @IBOutlet var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
