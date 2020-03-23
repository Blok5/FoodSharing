import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var LogOutButton: UIButton!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    var presentor: SettingsViewPresentorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeDependencies()
        presentor.configureUserData()
        presentor.downloadIcon()
    }
    
    private func initializeDependencies() {
        let foodFeedTBC = tabBarController as! FoodUITabBarController
        presentor = SettingsPresentor(view: self, user: foodFeedTBC.user)
    }
    
    @IBAction func LogOutButtonOnClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "Вы уверены, что хотите выйти?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { [weak self] (action) in
            guard let hardSelf = self else { return }
            
            hardSelf.presentor.logOut()
        }))
        
        present(alert, animated: true)
    }
    
}

extension SettingsViewController: SettingsViewDelegate {
    func showUserData(name: String) {
        UserNameLabel.text = name
    }
    
    func showIcon(icon: UIImage) {
        profilePhoto.image = icon
    }
    
    func showLoginModule() {
        performSegue(withIdentifier: "showLoginModule", sender: self)
    }
}
