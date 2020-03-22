//
//  FoodUITabBarController.swift
//  Lesson3_class
//
//  Created by Игорь Симаков on 01.03.2020.
//  Copyright © 2020 Игорь Симаков. All rights reserved.
//

import UIKit

class FoodUITabBarController: UITabBarController {
    var user: UserProfile?

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(user?.name)
//        print(user!)
        //Hide back button (when come back from log out)
        self.navigationItem.setHidesBackButton(true, animated: false)
        //print(user!)
    }

}
