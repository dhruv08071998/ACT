

import Foundation
import CoreData
public class UsageInfo: NSObject, NSCoding {

    var timeProgress: Int!
    var startTime: Int!
    var endTime: Int!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {
        timeProgress = dictionary["timeProgress"] as? Int
        startTime = dictionary["startTime"] as? Int
        endTime = dictionary["endTime"] as? Int
        
    }
    
    override init(){
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if timeProgress != nil {
            dictionary["timeProgress"] = timeProgress
        }
        if startTime != nil {
            dictionary["startTime"] = startTime
        }
        if endTime != nil {
            dictionary["endTime"] = endTime
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        timeProgress = aDecoder.decodeObject(forKey: "timeProgress") as? Int
        endTime = aDecoder.decodeObject(forKey: "endTime") as? Int
        startTime = aDecoder.decodeObject(forKey: "startTime") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if timeProgress != nil {
            aCoder.encode(timeProgress, forKey: "timeProgress")
        }
        if startTime != nil {
            aCoder.encode(startTime, forKey: "startTime")
        }
        if endTime != nil {
            aCoder.encode(endTime, forKey: "endTime")
        }
      
    }
}



