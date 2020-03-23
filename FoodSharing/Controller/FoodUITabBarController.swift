import UIKit

class FoodUITabBarController: UITabBarController {
    var user: UserProfile!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide back button (when come back from log out)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

}
