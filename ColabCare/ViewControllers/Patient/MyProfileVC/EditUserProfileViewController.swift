//
//  EditUserProfileViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/16/21.
//

import UIKit
import ChatSDK
class EditUserProfileViewController: UIViewController{

    @IBOutlet weak var viewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "DetailedProfile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfile") as? BDetailedEditProfileTableViewController
        var nc: UINavigationController? = nil
        if let vc = vc {
            nc = UINavigationController(rootViewController: vc)
        }
        if let nc = nc {
            self.embed(nc, inView: viewContainer)
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            saveFromChatSDK()
        self.dismiss(animated: true, completion: nil)
        }
    }
    func embed(_ viewController:UINavigationController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
