//
//  ModuleBuilder.swift
//  FoodSharing
//
//  Created by Игорь Симаков on 15.03.2020.
//  Copyright © 2020 Игорь Симаков. All rights reserved.
//

import UIKit

protocol Builder {
    static func createLogin() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createLogin() -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter(view: view)
        view.presenter = presenter
        
        return view
        
    }

}
