//
//  Goal.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 5/20/21.
//

import Foundation
import CoreData
public class Appointment: NSObject, NSCoding {

    var patientName: String!
    var notes: String!
    var date: String!
    var time: String!
    var timeAndDate: Date!
    var appointmentType: String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {
        patientName = dictionary["patientName"] as? String
        notes = dictionary["notes"] as? String
        date = dictionary["date"] as? String
        time = dictionary["time"] as? String
        timeAndDate = dictionary["timeAndDate"] as? Date
        appointmentType = dictionary["appointmentType"] as? String
    }
    
    override init(){
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if patientName != nil {
            dictionary["patientName"] = patientName
        }
        if notes != nil {
            dictionary["notes"] = notes
        }
        if date != nil {
            dictionary["date"] = date
        }
        if time != nil {
            dictionary["time"] = time
        }
        if timeAndDate != nil {
            dictionary["timeAndDate"] = timeAndDate
        }
        if appointmentType != nil {
            dictionary["appointmentType"] = appointmentType
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        patientName = aDecoder.decodeObject(forKey: "patientName") as? String
        notes = aDecoder.decodeObject(forKey: "notes") as? String
        date = aDecoder.decodeObject(forKey: "date") as? String
        time = aDecoder.decodeObject(forKey: "time") as? String
        timeAndDate = aDecoder.decodeObject(forKey: "timeAndDate") as? Date
        appointmentType = aDecoder.decodeObject(forKey: "appointmentType") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if patientName != nil {
            aCoder.encode(patientName, forKey: "patientName")
        }
        if notes != nil {
            aCoder.encode(notes, forKey: "notes")
        }
        if date != nil {
            aCoder.encode(date, forKey: "date")
        }
        if time != nil {
            aCoder.encode(time, forKey: "time")
        }
        if timeAndDate  != nil {
            aCoder.encode(timeAndDate , forKey: "timeAndDate")
        }
        if appointmentType != nil {
            aCoder.encode(appointmentType, forKey: "appointmentType")
        }
    }
}
