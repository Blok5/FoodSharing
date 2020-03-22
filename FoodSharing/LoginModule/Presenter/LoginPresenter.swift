import SwiftyVK

protocol LoginViewDelegate: class {
    func showTabBarController()
    func showError(with message: String)
}

protocol LoginViewPresenterProtocol {
    init(view: LoginViewDelegate)
    func login()
    func performSegueIfUserLoggedIn()
    func willPerformSegue(for segue: UIStoryboardSegue)
}

class LoginPresenter: LoginViewPresenterProtocol {
    private unowned let view: LoginViewDelegate!
    private var userProfile: UserProfile?
    
    required init(view: LoginViewDelegate) {
        self.view = view
    }
    
    func performSegueIfUserLoggedIn() {
        switch VK.sessions.default.accessToken {
        case .none:
            break
        case .some(let accessToken):
            if accessToken.isValid {
                self.populateUserProfileAndShowTabBarIfSuccess()
            } else {
                break
            }
        }
    }
    
    func login() {
        VK.sessions.default.logIn(
            onSuccess: { info in
                //print(info)
                self.populateUserProfileAndShowTabBarIfSuccess()
        },  onError: { [weak self] error in
            guard let hardSelf = self else { return }
            hardSelf.view.showError(with: "Не удалось авторизироваться, попробуйте еще раз")
        })
    }
    
    func getUserProfile(completion: @escaping (Result<UserProfileService>) -> Void) {
        VK.API.Users.get([.fields: "sex,bdate,city,first_name,last_name,photo_200"])
            .onSuccess({ (data) in
                //print(try JSONSerialization.jsonObject(with: data))
                do {
                    completion(.success(try JSONDecoder().decode([UserProfileService].self, from: data).first!))
                } catch let parsingError {
                    print("Error: ", parsingError)
                }
            })
            .send()
    }
    
    func populateUserProfileAndShowTabBarIfSuccess() {
        self.getUserProfile { [weak self] result in
            guard let hardSelf = self else { return }
            switch result {
            case .success(let data):
                hardSelf.userProfile = UserProfile(userService: data)
                hardSelf.view.showTabBarController()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func willPerformSegue(for segue: UIStoryboardSegue) {
        let vc = segue.destination as! FoodUITabBarController
        vc.user = self.userProfile!
    }
    
}
