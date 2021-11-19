//
//  CollectionViewCell.swift
//  taskCollectionFlowLayout
//
//  Created by Yogesh Patel on 21/04/18.
//  Copyright © 2018 Yogesh Patel. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var constatinImageHeight: NSLayoutConstraint!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet var img: UIImageView!
    @IBOutlet weak var meditationName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice().type.rawValue == "iPhone 7" || UIDevice().type.rawValue == "iPhone 8" || UIDevice().type.rawValue == "iPhone 8 Plus" || UIDevice().type.rawValue == "iPhone 7 Plus" || UIDevice().type.rawValue == "iPhone SE (2nd generation)"  ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6S" ||  UIDevice().type.rawValue == "iPhone 6S Plus"{
            constatinImageHeight.constant = 100
        }
        self.mainView.layer.cornerRadius = 13.0
        self.mainView.layer.borderColor = UIColor.blue.cgColor
        self.mainView.layer.borderWidth = 1
    }

}
