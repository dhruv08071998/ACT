//
//  PatientMessageViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/26/21.
//


import UIKit

class PatientMessageViewController: UIViewController {
    @IBOutlet weak var lineTwo: UILabel!
    @IBOutlet var lineOne: UILabel!
    @IBOutlet weak var btnSegmentOne: UIButton!
    @IBOutlet var btnSengmentTwo: UIButton!
//    @IBOutlet var btnSengmentOne: UIButton!
    @IBOutlet var containerView: UIView!
    var toggler = Int()
    
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    private lazy var firstViewController: ChatViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: KEY.STORYBOARD.Main, bundle: Bundle.main)
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.ChatViewController) as! ChatViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var secondViewController: ChatContactsViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: KEY.STORYBOARD.Main, bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.ChatContactsViewController) as! ChatContactsViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }

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
        toggler = 1
        updateView()
        lineTwo.isHidden = false
        lineOne.isHidden = true
        btnSengmentTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnSegmentOne.titleLabel?.font = UIFont.systemFont(ofSize: 23)
    }
    @IBAction func btnSegmentOneTapped(_ sender: Any) {
        toggler = 0
        updateView()
        lineOne.isHidden = false
        lineTwo.isHidden = true
        btnSegmentOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnSengmentTwo.titleLabel?.font = UIFont.systemFont(ofSize: 23)
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

    override func viewDidLoad() {
        super.viewDidLoad()
       lineOne.isHidden = false
        btnSegmentOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        lineTwo.isHidden = true
        self.setupView()
        self.navigationController?.setNavigationBarHidden(true, animated:true)
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

