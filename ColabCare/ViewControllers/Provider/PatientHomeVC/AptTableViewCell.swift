//
//  AptTableViewCell.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 8/3/21.
//

import UIKit

class AptTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAppointmentType: UIImageView!
    @IBOutlet weak var viewApt: UIView!
    @IBOutlet weak var lblTime: InsetLabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblPatinet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewApt.layer.cornerRadius = 12
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
