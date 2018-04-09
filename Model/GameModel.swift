
import UIKit

class GameModel {
    
    init() {
        name = ""
        popularity = 0
        id = 0
        giantbomb_id = 0
        box = Images()
        logo = Images()
    }
    
    init (json: JSONDictionary) {
        name = json["name"] as! String
        popularity = json["popularity"] as! Int
        id = json["_id"] as! Int
        giantbomb_id = json["giantbomb_id"] as! Int
        self.box = Images(json: json["box"] as! NSDictionary)
        self.logo = Images(json: json["logo"] as! NSDictionary)
        
    }
    
    var name: String
    var popularity: Int
    var id: Int
    var giantbomb_id: Int
    var box = Images()
    var logo = Images()
}
