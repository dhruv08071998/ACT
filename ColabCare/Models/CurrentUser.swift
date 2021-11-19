//
//  Reminder.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 5/27/21.
//

import Foundation
public class CurrentUser: NSObject, NSCoding {

    var username: String?
    var email: String?
    var profileURL: String?
    var medicineTime: [String]?
    var arrDates: [Date]?
    var intialDate: String?
    var arrMessages: [String]?
    var arrDosage: [String]?
    var userType: String?

    

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {
        username = dictionary["username"] as? String
        email = dictionary["email"] as? String
        profileURL = dictionary["endDate"] as? String
        intialDate = dictionary["intialDate"] as? String
        userType = dictionary["userType"] as? String
        medicineTime = [String]()
        if let times = dictionary["medicineTime"] as? [String]{
            for obj in times {
                medicineTime?.append(obj)
            }
        }
        arrDosage = [String]()
        if let times = dictionary["arrDosage"] as? [String]{
            for obj in times {
                arrDosage?.append(obj)
            }
        }
        arrDates = [Date]()
        if let times = dictionary["arrDates"] as? [Date]{
            for obj in times {
                arrDates?.append(obj)
            }
        }
        arrMessages = [String]()
        if let times = dictionary["arrMessages"] as? [String]{
            for obj in times {
                arrMessages?.append(obj)
            }
        }
       
    }
    
    override init(){
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if username != nil {
            dictionary["username"] = username
        }
        if userType != nil {
            dictionary["userType"] = userType
        }
        if email != nil {
            dictionary["email"] = email
        }
        if profileURL != nil {
            dictionary["endDate"] = profileURL
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        username = aDecoder.decodeObject(forKey: "username") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        profileURL = aDecoder.decodeObject(forKey: "endDate") as? String
        userType = aDecoder.decodeObject(forKey: "userType") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if username != nil {
            aCoder.encode(username, forKey: "username")
        }
        if email != nil {
            aCoder.encode(email, forKey: "email")
        }
        if profileURL != nil {
            aCoder.encode(profileURL, forKey: "endDate")
        }
        if userType != nil {
            aCoder.encode(userType, forKey: "userType")
        }
      
    }
}

