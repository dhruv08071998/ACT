

import Foundation
import CoreData
public class Info: NSObject, NSCoding {

    var endTime: Int!
    var startTime: Int!
    var timeProgress: Int!
    var meditationTitle: String!
    var meditationId: Int!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {
        endTime = dictionary["endTime"] as? Int
        startTime = dictionary["startTime"] as? Int
        timeProgress = dictionary["timeProgress"] as? Int
        meditationTitle = dictionary["meditationTitle"] as? String
        meditationId = dictionary["meditationId"] as? Int
    }
    
    override init(){
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if endTime != nil {
            dictionary["endTime"] = endTime
        }
        if startTime != nil {
            dictionary["startTime"] = startTime
        }
        if timeProgress != nil {
            dictionary["timeProgress"] = timeProgress
        }
        if meditationTitle != nil {
            dictionary["meditationTitle"] = meditationTitle
        }
        if meditationId != nil {
            dictionary["meditationId"] = meditationId
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        endTime = aDecoder.decodeObject(forKey: "endTime") as? Int
        startTime = aDecoder.decodeObject(forKey: "startTime") as? Int
        timeProgress = aDecoder.decodeObject(forKey: "timeProgress") as? Int
        meditationTitle = aDecoder.decodeObject(forKey: "meditationTitle") as? String
        meditationId = aDecoder.decodeObject(forKey: "meditationId") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if endTime != nil {
            aCoder.encode(endTime, forKey: "endTime")
        }
        if startTime != nil {
            aCoder.encode(startTime, forKey: "startTime")
        }
        if timeProgress != nil {
            aCoder.encode(timeProgress, forKey: "timeProgress")
        }
        if meditationTitle != nil {
            aCoder.encode(meditationTitle, forKey: "meditationTitle")
        }
        if meditationId != nil {
            aCoder.encode(meditationId, forKey: "meditationId")
        }
    }
}


