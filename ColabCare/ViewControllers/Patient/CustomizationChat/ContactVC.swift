//
//  ContactVC.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/14/21.
//

import UIKit
import ChatSDK
class ContactVC: BContactsViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnAddContact: UserDefineBtn!
    @IBOutlet weak var viewContainer: UIView!
    var usesData = [PUserConnection]()
    
    override func viewDidLoad() {
        txtSearch.delegate = self
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        viewContainer.backgroundColor = .clear
        let vc = BChatSDK.ui().contactsViewController()
        embed(vc!, inView: viewContainer)
        btnAddContact.layer.cornerRadius = btnAddContact.frame.height/2
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                NotificationCenter.default.post(name: NSNotification.Name("rightChat"),object: nil)
            default:
                break
            }
        }
    }
    
    @IBAction func btnAddContactTapped(_ sender: Any) {
        openSearchView(withType: "NameSearch")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefineBtn.color != themeColor{
            UserDefineBtn.updateView(view: btnAddContact)
        }
        NotificationCenter.default.post(name: NSNotification.Name("loadContacts"),object: nil)
    }
    
}

extension ContactVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let dic = ["searchTextData": textField.text!, "string": string,"txtSearchContact": txtSearch.text!]
        NotificationCenter.default.post(name: NSNotification.Name("searchContacts"),object: dic)
        return true
    }
    
}
