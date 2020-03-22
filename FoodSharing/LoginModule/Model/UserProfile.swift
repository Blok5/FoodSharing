import Foundation
import UIKit
import ResourceNetworking
import SwiftyVK

protocol UserProfileDelegate: AnyObject {
    func iconDidLoaded(userProfile: UserProfile)
}

class UserProfile {
    let uuid = UUID().uuidString
    var vkid: Int?
    var name: String
    var surname: String
    var city: String
    var userEmail: String?
    
    var activeFoodLotArray: FoodLot?

    var givenFoodArray: FoodLot?
    
    private var cancel: Cancellation?
    private var iconUrl: String?
    
    weak var delegate: UserProfileDelegate?
    
    private(set) var icon: UIImage? {
        didSet {
            delegate?.iconDidLoaded(userProfile: self)
        }
    }
    
    init(userService: UserProfileService) {
        self.name = userService.name
        self.surname = userService.surname
        self.vkid = userService.id
        self.city = userService.city.title
        self.iconUrl = userService.iconUrl
    }
    
}

extension UserProfile {
    func downloadPhoto(with helper: NetworkHelper) {
        if (icon != nil || cancel != nil) {
            return
        }
        
        guard let iconResource = ResourceFactor().createIconResource(for: self.iconUrl!) else {
            return
        }
        
        cancel = helper.load(resource: iconResource, completion: { [weak self] (result) in
            switch result {
            case let .success(image):
                self?.icon = image
            case let .failure(error):
                print(error)
            }
            self?.cancel = nil
        })
    }
    
    func cancelDownloadPhoto() {
        cancel?.cancel()
        cancel = nil
    }
}

struct ResourceFactor {
    func createIconResource(for urlString: String) -> Resource<UIImage>? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let parse: (Data) throws -> UIImage = { (data) in
            guard let image = UIImage(data: data) else {
                throw NSError(domain:  "can't create UIImage from data \(data)", code: 129, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("myString", comment: "comment")])
            }
            return image
        }
        return Resource(url: url, method: .get, parse: parse)
    }
}
