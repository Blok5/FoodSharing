import SwiftyVK

protocol LoginViewProtocol: class {
    func showAlert()
    func performSegue(userProfile: UserProfile)
}

protocol LoginViewPresenterProtocol {
    init(view: LoginViewProtocol)
    func getUserDataAndPerformSegueIfSuccess()
    func login()
}

class LoginPresenter: LoginViewPresenterProtocol {
    let view: LoginViewProtocol!
    
    var userProfile: UserProfile?
    var userEmail: String?
    
    required init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func login() {
        VK.sessions.default.logIn(
            onSuccess: { info in
                self.getUserDataAndPerformSegueIfSuccess()
        },  onError: { error in
            print("SwiftyVK: authorize failed with ", error)
        })
        
        //        switch VK.sessions.default.state {
        //        case .authorized:
        //            getUserDataAndPerformSegueIfSuccess()
        //        default:
        //            break
        //        }
    }
    
    //TODO: Get data only in first time when registrated.
    func getUserDataAndPerformSegueIfSuccess() {
        VK.API.Users.get([
            .fields: "sex,bdate,city,first_name,last_name,photo_200"
        ])
            .onSuccess({ (data) in
                print(try JSONSerialization.jsonObject(with: data))
                do {
                    let parsedUser = try JSONDecoder().decode([GetUserAPI].self, from: data).first!
                    
                        self.view.performSegue(userProfile: UserProfile(userService: parsedUser))
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
            })
            .send()
    }
    
}
