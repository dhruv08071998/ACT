//
//  ChangeThemeViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 6/19/21.
//

import UIKit

class ChangeThemeViewController: UIViewController {
    
    @IBOutlet weak var btnApply: UserDefineBtn!
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    @IBOutlet weak var lblBlue: UILabel!
    @IBOutlet weak var lblGreen: UILabel!
    @IBOutlet weak var lblPurple: UILabel!
    @IBOutlet weak var checkBtnBlue: UIButton!
    @IBOutlet weak var checkBtnGreen: UIButton!
    @IBOutlet weak var checkBtnPurple: UIButton!
    @IBOutlet weak var viewGreen: UIView!
    @IBOutlet weak var viewBlue: UIView!
    @IBOutlet weak var viewPurple: UIView!
    var isCheckBlue = false
    var isCheckGreen = false
    var isCheckPurple = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewGreen.layer.borderWidth = 1
        viewGreen.layer.cornerRadius = 8
        viewGreen.layer.borderColor = .white()
        viewPurple.layer.borderWidth = 1
        viewPurple.layer.cornerRadius = 8
        viewPurple.layer.borderColor = .white()
        viewBlue.layer.borderWidth = 1
        viewBlue.layer.cornerRadius = 8
        viewBlue.layer.borderColor = .white()
        checkBtnBlue.addTarget(self, action: #selector(btnCheckBoxBlue(_:)), for: .touchUpInside)
        checkBtnGreen.addTarget(self, action: #selector(btnCheckBoxGreen(_:)), for: .touchUpInside)
        checkBtnPurple.addTarget(self, action: #selector(btnCheckBoxPurple(_:)), for: .touchUpInside)
        navigationController?.setNavigationBarHidden(true, animated:true)
        changeBackground(view: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if themeFlag == 3 {
            btnCheckBoxBlue(checkBtnBlue)
        }
        if themeFlag == 1 {
            btnCheckBoxGreen(checkBtnGreen)
        }
        if themeFlag == 2 {
            btnCheckBoxPurple(checkBtnPurple)
        }
    }
    
    @IBAction func btnBlueTapped(_ sender: Any) {
        btnCheckBoxBlue(checkBtnBlue)
    }
    @IBAction func btnPurpleTapped(_ sender: Any) {
        btnCheckBoxPurple(checkBtnPurple)
    }
    @IBAction func btnGreenTapped(_ sender: Any) {
        btnCheckBoxGreen(checkBtnGreen)
    }
    @objc func btnCheckBoxBlue(_ sender: UIButton) {
        if isCheckBlue {
            sender.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckBlue = !isCheckBlue
        } else {
            sender.setImage(UIImage(named: "iconRadioCheck"), for: .normal)
            isCheckBlue = !isCheckBlue
            themeColor = lblBlue.backgroundColor
            checkBtnGreen.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckGreen = false
            checkBtnPurple.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckPurple = false
            themeFlag = 3
            updateTheme()
        }
    }
    @objc func btnCheckBoxGreen(_ sender: UIButton) {
        if isCheckGreen {
            sender.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckGreen = !isCheckGreen
        } else {
            sender.setImage(UIImage(named: "iconRadioCheck"), for: .normal)
            isCheckGreen = !isCheckGreen
            themeColor = lblGreen.backgroundColor
            checkBtnPurple.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckPurple = false
            checkBtnBlue.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckBlue = false
            themeFlag = 1
            updateTheme()
        }
    }
    @objc func btnCheckBoxPurple(_ sender: UIButton) {
        if isCheckPurple {
            sender.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckPurple = !isCheckPurple
        } else {
            sender.setImage(UIImage(named: "iconRadioCheck"), for: .normal)
            isCheckPurple = !isCheckPurple
            themeColor = lblPurple.backgroundColor
            checkBtnGreen.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckGreen = false
            checkBtnBlue.setImage(UIImage(named: "icon-radio-UNcheck"), for: .normal)
            isCheckBlue = false
            themeFlag = 2
            updateTheme()
        }
    }
    
    func updateTheme() {
        if UserDefineBtn.color != themeColor{
            NavigationHeaderView.updateView(view: viewNavigation)
            UserDefineBtn.updateView(view: btnApply)
            changeBackground(view: self.view)
        }
        storeTheme()
    }
    @IBAction func btnApplysTapped(_ sender: Any) {
        if !isCheckBlue  && !isCheckPurple && !isCheckGreen {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.select_one_theme)
        } else {
            moveTobackScreen()
        }
    }
    

}
