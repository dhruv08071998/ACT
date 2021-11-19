//
//  ChatShowViewController.swift
//  ColabCare
//
//  Created by Dhruv Upadhyay on 23/04/21.
//

import UIKit
import ChatSDK
class ChatContactsViewController: UIViewController {
    @IBOutlet weak var viewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        changeBackground(view: self.view)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ContactVC") as! ContactVC
        embed(vc, inView: viewContainer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewContainer.backgroundColor = .clear
        UIApplication.shared.applicationIconBadgeNumber = 0
        if UserDefineBtn.color != themeColor{
            changeBackground(view: self.view)
        }
    }

}
