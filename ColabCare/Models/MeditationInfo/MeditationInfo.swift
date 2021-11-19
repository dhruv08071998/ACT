

import Foundation
import CoreData
public class MeditationInfo: NSObject, NSCoding {

    var goalName: String!
    var modules: [Modules]!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]) {
        goalName = dictionary["goalName"] as? String
        if let times = dictionary["modules"] as? [Modules]{
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
        if goalName != nil {
            dictionary["goalName"] = goalName
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
        goalName = aDecoder.decodeObject(forKey: "goalName") as? String
        modules = aDecoder.decodeObject(forKey: "modules") as? [Modules]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if goalName != nil {
            aCoder.encode(goalName, forKey: "goalName")
        }
        if modules != nil {
            aCoder.encode(modules, forKey: "modules")
        }
    }
}

