
import UIKit

class ResponseItemModel{
    
    
    init(){
        game = GameModel()
        viewers = 0
        channels = 0
    }
    
    init (json: JSONDictionary){
        viewers = json["viewers"] as! Int
        channels = json["channels"] as! Int
        game = GameModel(json:json["game"] as! JSONDictionary)
    }
    
    var game: GameModel
    var viewers: Int
    var channels: Int
}
