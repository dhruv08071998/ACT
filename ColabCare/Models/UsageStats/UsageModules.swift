

import Foundation
import CoreData
public class UsageModules: NSObject, NSCoding {

    var count: Int!
    var usageInfo: [UsageInfo]!
    var meditationTitle: String!
    var meditationId: Int!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {
        meditationTitle = dictionary["meditationTitle"] as? String
        meditationId = dictionary["meditationId"] as? Int
        count = dictionary["count"] as? Int
        if let times = dictionary["usageInfo"] as? [UsageInfo]{
            for obj in times {
                usageInfo?.append(obj)
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
        if count != nil {
            dictionary["count"] = count
        }
        if meditationId != nil {
            dictionary["meditationId"] = meditationId
        }
        if meditationTitle != nil {
            dictionary["meditationTitle"] = meditationTitle
        }
        if usageInfo != nil {
            dictionary["usageInfo"] = usageInfo
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        count = aDecoder.decodeObject(forKey: "count") as? Int
        usageInfo = aDecoder.decodeObject(forKey: "usageInfo") as? [UsageInfo]
        meditationId = aDecoder.decodeObject(forKey: "meditationId") as? Int
        meditationTitle = aDecoder.decodeObject(forKey: "meditationTitle") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if count != nil {
            aCoder.encode(count, forKey: "count")
        }
        if usageInfo != nil {
            aCoder.encode(usageInfo, forKey: "usageInfo")
        }
        if meditationId != nil {
            aCoder.encode(meditationId, forKey: "meditationId")
        }
        if meditationTitle != nil {
            aCoder.encode(meditationTitle, forKey: "meditationTitle")
        }
    }
}


