//
//  PrivateThreadVC.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/13/21.
//

import UIKit
import ChatSDK
class PrivateThreadVC: BPrivateThreadsViewController {
    
    var copyThreads = [PThread]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
    }
    override func pushChatViewController(with thread: PThread!) {
        if (thread != nil) {
            threadChat = thread
            threadUserName = myThreadName!
            threadUserProfile = threadChat?.imageURL()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ChatThreadVC") as! ChatThreadVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .left:
                NotificationCenter.default.post(name: NSNotification.Name("leftChat"),object: nil)
            default:
                break
            }
        }
    }
    
}

