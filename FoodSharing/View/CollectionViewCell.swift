//
//  CollectionViewCell.swift
//  Lesson3_class
//
//  Created by Игорь Симаков on 09.03.2020.
//  Copyright © 2020 Игорь Симаков. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var foodPhoto: UIImageView!
    
    func displayContent(image: UIImage) {
        self.foodPhoto.image = image
    }
}
