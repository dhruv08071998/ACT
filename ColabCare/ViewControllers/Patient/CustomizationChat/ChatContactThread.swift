//
//  ChatContactThread.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 7/17/21.
//

import UIKit
import ChatSDK
class ChatContactThread: BContactsViewController {

    lazy var searchBar:UISearchBar = UISearchBar()
    var copyContacts = [PUserConnection]()
    private var navigationBar: UINavigationBar!
    private var customNavigationItem: UINavigationItem!
    var searchText: String = ""
    var isEmpty = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
            .addObserver(self,
                         selector:#selector(searchContacts(_:)),
                         name: NSNotification.Name ("searchContacts"),object: nil)
//        NotificationCenter.default
//            .addObserver(self,
//                         selector:#selector(loadContacts(_:)),
//                         name: NSNotification.Name ("loadContacts"),object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadUsersAccordingToType()
    }
    
//    @objc func loadContacts(_ notification: Notification) {
//      reloadData()
//    }
    
    
    override func getThreadAndName(){
        threadUserName = chatUserName as String?
        threadChat = chatThread
        threadUserProfile = chatThread.imageURL()
    }

    @objc func searchContacts(_ notification: Notification) {
        isEmpty = false
        let dict = notification.object as? NSDictionary
        let string = dict!["string"] as! String
        let textField = dict!["searchTextData"] as! String
        let txtSearchContact = dict!["txtSearchContact"] as! String
        if string.isEmpty {
            searchText = String(searchText.dropLast())
            if (txtSearchContact.dropLast().isEmpty) {
                isEmpty = true
            }
        } else {
            searchText = textField + string
        }
        let contactsAll = contacts()  as! [PUserConnection]
        copyContacts = searchText.isEmpty ? contactsAll : contactsAll.filter({ (flag) -> Bool in
            return flag.user().name().range(of: searchText.trimmingTrailingSpaces, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        tableView.reloadData()
    }
    
    override func reloadData() {
        contacts().removeAllObjects()
        var contactsAll: [PUserConnection] = BChatSDK.currentUser().connections(with: bUserConnectionTypeContact) as! [PUserConnection]
        for con in contactsAll {
            if con.user().userType() == returnOpponentUser() {
                contacts().add(con)
            }
        }
        contacts().sortOnlineThenAlphabetical()
        copyContacts = contacts() as! [PUserConnection]
        tableView.reloadData()
    }
    
    func returnOpponentUser() -> String {
        var opponentString = ""
        if userIndex == 0{
            opponentString = "PATIENT"
        } else {
            opponentString = "PROVIDER"
        }
        return opponentString
    }
    
    override func loadUsersAccordingToType() {
        BChatSDK.search().users(forIndexes: nil, withValue: "3534534535", limit: 20) { [self] user in
            if user?.email() != BChatSDK.currentUser().email() && user?.userType() == returnOpponentUser() && user?.name() != nil{
                BChatSDK.core().observeUser(user?.entityID())
                BChatSDK.contact().addContact(user, with: bUserConnectionTypeContact)
            }
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return copyContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BUserCell = tableView.dequeueReusableCell(withIdentifier: "bCellIdentifier")! as! BUserCell
        let connection = copyContacts[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.setUser(connection.user())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let connection = copyContacts[indexPath.row]
        BChatSDK.thread().createThread(withUsers: [connection.user()]) { error, thread in
            threadUserName = thread?.displayName()
            threadChat = thread
            threadUserProfile = thread?.imageURL()
        }
        let profileView = BChatSDK.ui().profileViewController(with: connection.user())
        profileView?.hidesBottomBarWhenPushed = true
        let navBar = UINavigationController.init(rootViewController: profileView!)
        navBar.modalPresentationStyle = .fullScreen
        self.present(navBar, animated: true, completion: nil)
    }
}
