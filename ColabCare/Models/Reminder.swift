//
//  Reminder.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 5/27/21.
//

import Foundation
public class Reminder: NSObject, NSCoding {

    var medicineName: String?
    var duration: String?
    var freqIntake: String?
    var medicineTime: [String]?
    var arrDates: [Date]?
    var intialDate: String?
    var arrMessages: [String]?
    var arrDosage: [String]?

    

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {
        medicineName = dictionary["medicineName"] as? String
        duration = dictionary["duration"] as? String
        freqIntake = dictionary["endDate"] as? String
        intialDate = dictionary["intialDate"] as? String
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
        if medicineName != nil {
            dictionary["medicineName"] = medicineName
        }
        if duration != nil {
            dictionary["duration"] = duration
        }
        if freqIntake != nil {
            dictionary["endDate"] = freqIntake
        }
        if intialDate != nil {
            dictionary["intialDate"] = intialDate
        }
        if medicineTime != nil {
            dictionary["medicineTime"] = medicineTime
        }
        if arrDates != nil {
            dictionary["arrDates"] = arrDates
        }
        if arrMessages != nil {
            dictionary["arrMessages"] = arrMessages
        }
        if arrDosage != nil {
            dictionary["arrDosage"] = arrDosage
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        medicineName = aDecoder.decodeObject(forKey: "medicineName") as? String
        duration = aDecoder.decodeObject(forKey: "duration") as? String
        freqIntake = aDecoder.decodeObject(forKey: "endDate") as? String
        intialDate = aDecoder.decodeObject(forKey: "intialDate") as? String
        medicineTime = aDecoder.decodeObject(forKey: "medicineTime") as? [String]
        arrDates = aDecoder.decodeObject(forKey: "arrDates") as? [Date]
        arrMessages = aDecoder.decodeObject(forKey: "arrMessages") as? [String]
        arrDosage = aDecoder.decodeObject(forKey: "arrDosage") as? [String]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if medicineName != nil {
            aCoder.encode(medicineName, forKey: "medicineName")
        }
        if duration != nil {
            aCoder.encode(duration, forKey: "duration")
        }
        if freqIntake != nil {
            aCoder.encode(freqIntake, forKey: "endDate")
        }
        if intialDate != nil {
            aCoder.encode(intialDate, forKey: "intialDate")
        }
        if medicineTime != nil {
            aCoder.encode(medicineTime, forKey: "medicineTime")
        }
        if arrDates != nil {
            aCoder.encode(arrDates, forKey: "arrDates")
        }
        if arrMessages != nil {
            aCoder.encode(arrMessages, forKey: "arrMessages")
        }
        if arrDosage != nil {
            aCoder.encode(arrDosage, forKey: "arrDosage")
        }
    }
}

public class Reminders: NSObject, NSCoding {
    
    public var Reminders: [Reminder] = []
    
    enum Key:String {
        case Reminders = "Reminders"
    }
    
    init(Reminders: [Reminder]) {
        self.Reminders = Reminders
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(Reminders.self, forKey: Key.Reminders.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mReminders = aDecoder.decodeObject(forKey: Key.Reminders.rawValue) as! [Reminder]
        
        self.init(Reminders: mReminders)
    }
    
    
}
