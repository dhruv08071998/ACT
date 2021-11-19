

import Foundation
import CoreData
public class Modules: NSObject, NSCoding {

    var count: Int!
    var info: [Info]!
    var meditationTitle: String!
    var meditationId: Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {
        count = dictionary["count"] as? Int
        if let times = dictionary["info"] as? [Info]{
            for obj in times {
                info?.append(obj)
            }
        }
        meditationTitle = dictionary["meditationTitle"] as? String
        meditationId = dictionary["meditationId"] as? Int
    }
    
    override init(){
        
    }

    /**
     * Returns all the available property values in the form of [Int:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if count != nil {
            dictionary["count"] = count
        }
        if info != nil {
            dictionary["info"] = info
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
        count = aDecoder.decodeObject(forKey: "count") as? Int
        info = aDecoder.decodeObject(forKey: "info") as? [Info]
        meditationTitle = aDecoder.decodeObject(forKey: "meditationTitle") as? String
        meditationId = aDecoder.decodeObject(forKey: "meditationId") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if count != nil {
            aCoder.encode(count, forKey: "count")
        }
        if info != nil {
            aCoder.encode(info, forKey: "info")
        }
        if meditationTitle != nil {
            aCoder.encode(meditationTitle, forKey: "meditationTitle")
        }
        if meditationId != nil {
            aCoder.encode(meditationId, forKey: "meditationId")
        }
    }
}

