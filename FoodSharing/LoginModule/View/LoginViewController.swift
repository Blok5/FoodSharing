import UIKit

class LoginViewController: UIViewController, LoginViewDelegate {
    var presenter: LoginViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeDependencies()
        presenter.performSegueIfUserLoggedIn()
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func initializeDependencies() {
        presenter = LoginPresenter(view: self)
    }
    
    //MARK:  LoginView
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        self.presenter.login()
    }
    
    func showError(with message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { [unowned self] action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: Segue
    public func showTabBarController() {
        DispatchQueue.main.async { [weak self] in
            self?.performSegue(withIdentifier: "showTabBar", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.presenter.willPerformSegue(for: segue)
    }
    
}
