
import UIKit

class ViewGameDetail: UIViewController {
    
    var gameToShow = ResponseItemModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(gameToShow.game.name)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
