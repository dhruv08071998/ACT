//
//  Goal.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 5/20/21.
//

import Foundation
import CoreData
public class Goal: NSObject, NSCoding {

    var goalName: String!
    var notes: String!
    var intialDate: String!
    var completedBy: String!
    var tag: Bool!
    var goalId: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {
        goalName = dictionary["goalName"] as? String
        notes = dictionary["notes"] as? String
        intialDate = dictionary["intialDate"] as? String
        completedBy = dictionary["completedBy"] as? String
        tag = dictionary["tag"] as? Bool
        goalId = dictionary["goalId"] as? String
    }
    
    override init(){
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if goalName != nil {
            dictionary["goalName"] = goalName
        }
        if notes != nil {
            dictionary["notes"] = notes
        }
        if intialDate != nil {
            dictionary["intialDate"] = intialDate
        }
        if completedBy != nil {
            dictionary["completedBy"] = completedBy
        }
        if tag != nil {
            dictionary["tag"] = tag
        }
        if goalId != nil {
            dictionary["goalId"] = goalId
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        goalName = aDecoder.decodeObject(forKey: "goalName") as? String
        notes = aDecoder.decodeObject(forKey: "notes") as? String
        intialDate = aDecoder.decodeObject(forKey: "intialDate") as? String
        completedBy = aDecoder.decodeObject(forKey: "completedBy") as? String
        tag = aDecoder.decodeObject(forKey: "tag") as? Bool
        goalId = aDecoder.decodeObject(forKey: "goalId") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties Stringo the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if goalName != nil {
            aCoder.encode(goalName, forKey: "goalName")
        }
        if notes != nil {
            aCoder.encode(notes, forKey: "notes")
        }
        if intialDate != nil {
            aCoder.encode(intialDate, forKey: "intialDate")
        }
        if completedBy != nil {
            aCoder.encode(completedBy, forKey: "completedBy")
        }
        if tag != nil {
            aCoder.encode(tag, forKey: "tag")
        }
        if goalId != nil {
            aCoder.encode(goalId, forKey: "goalId")
        }
    }
}


public class Goals: NSObject, NSCoding {
    
    public var Goals: [Goal] = []
    
    enum Key:String {
        case Goals = "Goals"
    }
    
    init(Goals: [Goal]) {
        self.Goals = Goals
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(Goals, forKey: Key.Goals.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mGoals = aDecoder.decodeObject(forKey: Key.Goals.rawValue) as! [Goal]
        
        self.init(Goals: mGoals)
    }
    
    
}
