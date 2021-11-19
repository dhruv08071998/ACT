//
//  CurrentGoalTableViewCell.swift
//  ColabCare
//
//  Created by Dhruv Upadhyay on 22/04/21.
//

import UIKit

class CurrentGoalTableViewCell: UITableViewCell {

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
        lblNotes.adjustsFontSizeToFitWidth = true
        viewContainer.setupShadow()
        lblNotes.minimumScaleFactor = 0.5
        lblNotes.numberOfLines = 0
        viewContainer.layer.cornerRadius = 12
        viewContainer.layer.borderWidth = 2
        viewContainer.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        viewContainer.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)

        // Configure the view for the selected state
    }

}

extension UIView {
    func setupShadow() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.1215686275, blue: 0.1254901961, alpha: 1)
        self.layer.shadowColor = #colorLiteral(red: 0.9333333333, green: 0.937254902, blue: 0.9647058824, alpha: 1)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    func setupViewDesign() {
        self.dropShadow()
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = .black()
        self.layer.cornerRadius = 2
        let radius: CGFloat = self.frame.width / 2.0
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.1 * radius, height: self.frame.height))
        self.layer.cornerRadius = 2
        self.layer.shadowColor = #colorLiteral(red: 0.9058823529, green: 0.8980392157, blue: 1, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)  //Here you control x and y
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0 //Here your control your blur
        self.layer.masksToBounds =  false
        self.layer.shadowPath = shadowPath.cgPath
    }
    func dropShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.9333333333, green: 0.937254902, blue: 0.9647058824, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
