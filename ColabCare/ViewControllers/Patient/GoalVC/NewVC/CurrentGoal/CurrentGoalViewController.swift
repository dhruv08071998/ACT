//
//  ViewController.swift
//  ColabCare
//
//  Created by Dhruv Upadhyay on 06/03/21.
//

import UIKit
import CoreData
import SAConfettiView
import ChatSDK
class CurrentGoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ModalTransitionListener {
    
    func popoverDismissed() {
        if editedGoal != nil {
            currentGoals[editedGoal!] = Goal(fromDictionary: selectGoal! as [String: Any])
            editedGoal = nil
        } else {
            currentGoals.append(Goal(fromDictionary: selectGoal! as [String: Any]))
            isChecked.append(false)
        }
        selectGoal = nil
        storeData()
        self.tblViewCurrentGoal.reloadData()
    }
    
    @IBOutlet weak var btnAddGoal: UserDefineBtn!
    var imageView : UIImageView!
    var confettiView: SAConfettiView!
    @IBOutlet weak var tblViewCurrentGoal: UITableView!
    var isChecked = [false, false]
    var goals = [Goal]()
    var editedGoal: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: KEY.USERDEFAULT.goalId)
        changeBackground(view: self.view)
        btnAddGoal.layer.cornerRadius = btnAddGoal.frame.height/2
        self.tabBarController?.tabBar.isHidden = false
        tblViewCurrentGoal.isHidden = true
        assignbackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            self.imageView.isHidden = true
            self.tblViewCurrentGoal.isHidden = false
        }
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
    }
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .left:
                NotificationCenter.default.post(name: NSNotification.Name("left"),object: nil)
            default:
                break
            }
        }
    }
    
    func setupConfettiView() {
        confettiView = SAConfettiView(frame: self.view.bounds)
        confettiView.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                               UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                               UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                               UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                               UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
        confettiView.intensity = 0.5
        confettiView.type = .Diamond
        view.addSubview(confettiView)
        confettiView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ModalTransitionMediator.instance.setListener(listener: self)
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        retriveAllData()
        setupConfettiView()
        tblViewCurrentGoal.reloadData()
        if UserDefineBtn.color != themeColor{
            changeBackground(view: self.view)
            UserDefineBtn.updateView(view: btnAddGoal)
        }
        
    }
    
    func assignbackground(){
        do {
            let imageData = try Data(contentsOf: Bundle.main.url(forResource: "goal", withExtension: "gif")!)
            let background =  UIImage.gif(data: imageData)!
            imageView = UIImageView(frame: view.bounds)
            imageView.contentMode =  UIView.ContentMode.scaleAspectFit
            imageView.clipsToBounds = true
            imageView.image = background
            view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width-50).isActive = true
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
            view.sendSubviewToBack(imageView)
        } catch {
            print(error)
        }
    }
    
    
    
    @IBAction func btnAddGoalTapped(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentGoals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KEY.CELL.CurrentGoalTableViewCell) as! CurrentGoalTableViewCell
        if NetworkReachabilityManager()!.isReachable {
            db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("goals").document(String(currentGoals[indexPath.row].goalId)).setData(["complete_date": currentGoals[indexPath.row].completedBy.replaceDash(), "goal_notes": currentGoals[indexPath.row].notes, "goal_title": currentGoals[indexPath.row].goalName, "initial_date": currentGoals[indexPath.row].intialDate.replaceDash(), "tag": false])
        } else {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
        }
        cell.lblDate.text = currentGoals[indexPath.row].intialDate
        cell.lblTitleGoal.text =  currentGoals[indexPath.row].goalName
        cell.lblNotes.text = "Notes: " +  currentGoals[indexPath.row].notes
        cell.lblDateCompletedBy.text = currentGoals[indexPath.row].completedBy
        cell.btnEdit.addTarget(self, action: #selector(btnEditTapped(_:)), for: .touchUpInside)
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.btnDelete.addTarget(self, action: #selector(btnDeleteTapped(_:)), for: .touchUpInside)
        cell.btnSwap.tag = indexPath.row
        cell.btnSwap.addTarget(self, action: #selector(btnSwapTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @IBAction func addGoalBtnTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.AddGoalViewController) as! AddGoalViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @objc func btnEditTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: KEY.VIEWCONTROLLER.AddGoalViewController) as! AddGoalViewController
        vc.modalPresentationStyle = .fullScreen
        selectGoal =  currentGoals[sender.tag].toDictionary()
        editedGoal = sender.tag
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func btnDeleteTapped(_ sender: UIButton) {
        currentGoals.remove(at: sender.tag)
        tblViewCurrentGoal.reloadData()
        storeData()
    }
    
    @objc func btnSwapTapped(_ sender: UIButton) {
        confettiView.isHidden = false
        confettiView.startConfetti()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            confettiView.stopConfetti()
            confettiView.isHidden = true
        }
        db.collection("user_data").document(BChatSDK.currentUser().entityID()).collection("goals").document(String(currentGoals[sender.tag].goalId)).updateData(["complete_date": currentGoals[sender.tag].completedBy.replaceDash(), "goal_notes": currentGoals[sender.tag].notes!, "goal_title": currentGoals[sender.tag].goalName!, "initial_date": currentGoals[sender.tag].intialDate.replaceDash(), "tag": true])
        completedGoals.append(currentGoals[sender.tag])
        currentGoals.remove(at: sender.tag)
        storeData()
        tblViewCurrentGoal.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        confettiView.stopConfetti()
        confettiView.isHidden = true
    }
}



extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    func replaceDash() -> String {
        return self.replacingOccurrences(of: "/", with: "-")
    }
}
extension UIViewController{
    
    func storeData(){
        deleteAllData(entity: KEY.COREDATA.ENTITY.GoalData)
        createData(data: encryptObjs(goals: currentGoals), key: KEY.COREDATA.KEY.currentgoals)
        createData(data: encryptObjs(goals: completedGoals), key: KEY.COREDATA.KEY.completedgoals)
    }
    
    func encryptObjs(goals: [Goal]) -> [Goal] {
        var totalGoals = [Goal]()
        for goal in goals{
            let tempGoal = Goal()
            tempGoal.goalName = try! goal.goalName.aesEncrypt()
            tempGoal.notes = try! goal.notes.aesEncrypt()
            tempGoal.goalId = try! goal.goalId.aesEncrypt()
            tempGoal.intialDate = try! goal.intialDate.aesEncrypt()
            tempGoal.completedBy = try! goal.completedBy.aesEncrypt()
            totalGoals.append(tempGoal)
        }
        return totalGoals
    }
    
    func decryptObjs(goals: [Goal]) -> [Goal] {
        var totalGoals = [Goal]()
        for goal in goals{
            let tempGoal = Goal()
            tempGoal.goalName = try! goal.goalName.aesDecrypt()
            tempGoal.notes = try! goal.notes.aesDecrypt()
            tempGoal.goalId = try! goal.goalId.aesDecrypt()
            tempGoal.intialDate = try! goal.intialDate.aesDecrypt()
            tempGoal.completedBy = try! goal.completedBy.aesDecrypt()
            totalGoals.append(tempGoal)
        }
        return totalGoals
    }
    
    func retriveAllData() {
        currentGoals = decryptObjs(goals: retrieveData(key: KEY.COREDATA.KEY.currentgoals))
        completedGoals = decryptObjs(goals: retrieveData(key: KEY.COREDATA.KEY.completedgoals))
        
    }
    
    func createData(data: [Goal], key: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: KEY.COREDATA.ENTITY.GoalData, in: managedContext)!
        let cmsg = NSManagedObject(entity: userEntity, insertInto: managedContext) as! GoalData
        let mRanges = Goals(Goals: data)
        cmsg.setValue(mRanges, forKeyPath: key)
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData(key: String) -> [Goal] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        var sendData = [Goal]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: KEY.COREDATA.ENTITY.GoalData)
        do {
            let result = try managedContext.fetch(fetchRequest)
            var i = 0
            for data in result as! [NSManagedObject] {
                let mranges = data.value(forKey: key) as? Goals
                if mranges != nil {
                    for element in mranges!.Goals {
                        sendData.append(element)
                    }
                    i = i + 1
                }
            }
            
        } catch {
            
            print("Failed")
        }
        return sendData
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
}
