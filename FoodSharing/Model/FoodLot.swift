import Foundation

class FoodLot {
    let uuid = UUID().uuidString
    let postDate = Date()
    let userProfile: String
        
    var description : String
    var location: String
    var photoUrlArray: [String]
    var title: String
    
    init(userProfile: String, descriprion: String, title: String, location: String, photoUrlArray: [String]) {
        self.userProfile = userProfile
        self.description = descriprion
        self.location = location
        self.photoUrlArray = photoUrlArray
        self.title = title
    }
}
