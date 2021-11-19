//
//  ViewController.swift
//  Login_Signup
//
//  Created by Dhruv Upadhyay on 17/02/20.
//  Copyright © 2020 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class GoalSegmentViewController: UIViewController {
    @IBOutlet weak var lineTwo: UILabel!
    @IBOutlet var lineOne: UILabel!
    @IBOutlet weak var btnSegmentOne: UIButton!
    @IBOutlet var btnSengmentTwo: UIButton!
//    @IBOutlet var btnSengmentOne: UIButton!
    @IBOutlet var containerView: UIView!
    var toggler = Int()
    
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    private lazy var firstViewController: CurrentGoalViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "CurrentGoalViewController") as! CurrentGoalViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var secondViewController: CompletedGoalViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "CompletedGoalViewController") as! CompletedGoalViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }

//    static func viewController() -> ScreeningViewController {
//        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoalSegementedView") as! ScreeningViewController
//    }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func add(asChildViewController viewController: UIViewController) {

        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        containerView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }

    //----------------------------------------------------------------

    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }

    //----------------------------------------------------------------

    @IBAction func btnSegmentTwoTapped(_ sender: Any) {
        segmentOne()
    }
    @IBAction func btnSegmentOneTapped(_ sender: Any) {
        segmentTwo()
    }
    private func updateView() {
        if toggler == 0 {
            remove(asChildViewController: secondViewController)
            add(asChildViewController: firstViewController)
           
        } else {
            remove(asChildViewController: firstViewController)
            add(asChildViewController: secondViewController)
            
        }
    }

    //----------------------------------------------------------------

    func setupView() {
        updateView()
    }

    func segmentTwo() {
        toggler = 0
        updateView()
        lineOne.isHidden = false
        lineTwo.isHidden = true
        btnSegmentOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnSengmentTwo.titleLabel?.font = UIFont.systemFont(ofSize: 23)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       lineOne.isHidden = false
        btnSegmentOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        lineTwo.isHidden = true
        self.setupView()
        NotificationCenter.default
                          .addObserver(self,
                                       selector:#selector(completedGoal(_:)),
                         name: NSNotification.Name ("left"),object: nil)
        NotificationCenter.default
                          .addObserver(self,
                                       selector:#selector(currentGoal(_:)),
                         name: NSNotification.Name ("right"),object: nil)
        
    }
    
    @objc func completedGoal(_ notification: Notification){
        segmentOne()
    }
    
    @objc func currentGoal(_ notification: Notification){
        segmentTwo()
    }
    
    func segmentOne() {
        toggler = 1
        updateView()
        lineTwo.isHidden = false
        lineOne.isHidden = true
        btnSengmentTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnSegmentOne.titleLabel?.font = UIFont.systemFont(ofSize: 23)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefineBtn.color != themeColor{
            NavigationHeaderView.updateView(view: viewNavigation)
            SegmentedLabel.updateView(view: lineOne as! SegmentedLabel)
            SegmentedLabel.updateView(view: lineTwo as! SegmentedLabel)
            changeBackground(view: self.view)
        }
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}







