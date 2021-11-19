//
//  ProfileVC.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/14/21.
//

import UIKit
import ChatSDK
import SDWebImage
class ChatThreadVC: UIViewController {

    @IBOutlet weak var lblLastSeen: UILabel!
    @IBOutlet weak var opponentUserImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLastSeen()
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(updateLastSeen), userInfo: nil, repeats: true)
        let vc = BChatSDK.ui().chatViewController(with: threadChat)
        embed(vc!, inView: viewContainer)
        userName.text = threadUserName
        opponentUserImage.layer.cornerRadius = opponentUserImage.frame.height/2
        opponentUserImage.sd_setImage(with: URL(string: threadUserProfile!))
        if opponentUserImage.image == nil {
            opponentUserImage.image = UIImage(named: "user")
        }
    }
    
    @objc func updateLastSeen() {
        if (threadChat?.otherUser().online() == 1) {
            lblLastSeen.text = "Online"
        } else {
        BChatSDK.lastOnline()?.getLastOnline(for: threadChat?.otherUser()).thenOnMain({ [self]date in
            lblLastSeen.text =  (date as! NSDate).lastSeenTimeAgo()
        }, nil)
    }
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
