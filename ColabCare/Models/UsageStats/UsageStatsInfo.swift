

import Foundation
import CoreData
public class UsageStatsInfo: NSObject, NSCoding {

    var date: String!
    var modules: [UsageModules]!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {
        date = dictionary["date"] as? String
        if let times = dictionary["modules"] as? [UsageModules]{
            for obj in times {
                modules?.append(obj)
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
        if date != nil {
            dictionary["date"] = date
        }
        if modules != nil {
            dictionary["modules"] = modules
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        date = aDecoder.decodeObject(forKey: "date") as? String
        modules = aDecoder.decodeObject(forKey: "modules") as? [UsageModules]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if date != nil {
            aCoder.encode(date, forKey: "date")
        }
        if modules != nil {
            aCoder.encode(modules, forKey: "modules")
        }
    }
}


