
import UIKit

class Images {
    
    init() {
        large = ""
        medium = ""
        small = ""
        template = ""
    }
    
    init (json: NSDictionary!){
        large = json.value(forKey: "large") as! String
        medium = json.value(forKey: "large") as! String
        small = json.value(forKey: "large") as! String
        template = json.value(forKey: "large") as! String
    }
    
    var large: String
    var medium: String
    var small: String
    var template: String
}
