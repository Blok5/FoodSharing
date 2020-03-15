import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
    var presenter: LoginPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide back button (when come back from log out)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func performSegue(userProfile: UserProfile) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showTabBarController", sender: nil)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Login", message: "Ошибка при попытке входа, попробуйте еще раз!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        self.presenter.login()

    }
    
    
    //pass data into tab bar controller (How to pass data now with MVP?)
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! FoodUITabBarController
//        vc.user = self.newUser!
//    }

}
