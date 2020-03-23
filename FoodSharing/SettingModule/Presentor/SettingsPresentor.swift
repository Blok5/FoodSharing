//
//  SettingsPresentor.swift
//  FoodSharing
//
//  Created by Игорь Симаков on 23.03.2020.
//  Copyright © 2020 Игорь Симаков. All rights reserved.
//
import SwiftyVK
import ResourceNetworking
import Foundation

protocol SettingsViewDelegate: class {
    func showIcon(icon: UIImage)
    func showUserData(name: String)
    func showLoginModule()
}

protocol SettingsViewPresentorProtocol {
    init(view: SettingsViewDelegate, user: UserProfile)
    func logOut()
    func downloadIcon()
    func configureUserData()
}

class SettingsPresentor: SettingsViewPresentorProtocol {
    private unowned let view: SettingsViewDelegate!
    var user: UserProfile!
    let networkHelper = NetworkHelper(reachability: Reachability())
    
    required init(view: SettingsViewDelegate, user: UserProfile) {
        self.view = view
        self.user = user
        user.delegate = self
    }
    
    func logOut() {
        VK.sessions.default.logOut()
        print("user with token \(VK.sessions.default.id) was logged out")
        view.showLoginModule()
    }
    
    func downloadIcon() {
        user.downloadPhoto(with: networkHelper)
    }
    
    func configureUserData() {
        view.showUserData(name: user.name)
    }
}

extension SettingsPresentor: UserProfileDelegate {
    func iconDidLoaded(userProfile: UserProfile) {
        DispatchQueue.main.async { [weak self] in
            guard let hardSelf = self else { return }
            
            hardSelf.view.showIcon(icon: hardSelf.user.icon!)
        }
    }
    
}
