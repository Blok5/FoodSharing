import UIKit
import SwiftyVK
import ResourceNetworking

class SettingsViewController: UIViewController {
    @IBOutlet weak var LogOutButton: UIButton!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    let networkHelper = NetworkHelper(reachability: Reachability())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let foodFeedTBC = tabBarController as! FoodUITabBarController
        
        foodFeedTBC.user?.delegate = self
        
        UserNameLabel.text = foodFeedTBC.user?.name
        EmailLabel.text = foodFeedTBC.user?.userEmail
        
        foodFeedTBC.user?.downloadPhoto(with: networkHelper)
        
    }
    
    @IBAction func LogOutButtonOnClick(_ sender: UIButton) {
        VK.sessions.default.logOut()
        print("user with token \(VK.sessions.default.id) was logged out")
    }
}

extension SettingsViewController: UserProfileDelegate {
    func iconDidLoaded(userProfile: UserProfile) {
        DispatchQueue.main.async { [weak self] in
            guard let hardSelf = self else { return }
            
            let foodFeedTBC = hardSelf.tabBarController as! FoodUITabBarController
            
            hardSelf.profilePhoto.image = foodFeedTBC.user?.icon
        }
    }
}
