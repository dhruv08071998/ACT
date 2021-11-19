//
//  Reminder.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 5/27/21.
//

import Foundation
public class ReminderTrack: NSObject, NSCoding {

    var arrTime: [String]?
    var arrDates: [Date]?

    

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {

        arrTime = [String]()
        if let times = dictionary["arrTime"] as? [String]{
            for obj in times {
                arrTime?.append(obj)
            }
        }
        arrDates = [Date]()
        if let times = dictionary["arrDates"] as? [Date]{
            for obj in times {
                arrDates?.append(obj)
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

        if arrTime != nil {
            dictionary["arrTime"] = arrTime
        }
        if arrDates != nil {
            dictionary["arrDates"] = arrDates
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        arrTime = aDecoder.decodeObject(forKey: "arrTime") as? [String]
        arrDates = aDecoder.decodeObject(forKey: "arrDates") as? [Date]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {

        if arrTime != nil {
            aCoder.encode(arrTime, forKey: "arrTime")
        }
        if arrDates != nil {
            aCoder.encode(arrDates, forKey: "arrDates")
        }
    }
}

public class RemindersTrack: NSObject, NSCoding {
    
    public var RemindersTrack: [ReminderTrack] = []
    
    enum Key:String {
        case RemindersTrack = "RemindersTrack"
    }
    
    init(RemindersTrack: [ReminderTrack]) {
        self.RemindersTrack = RemindersTrack
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(RemindersTrack.self, forKey: Key.RemindersTrack.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mRemindersTrack = aDecoder.decodeObject(forKey: Key.RemindersTrack.rawValue) as! [ReminderTrack]
        
        self.init(RemindersTrack: mRemindersTrack)
    }
    
    
}

