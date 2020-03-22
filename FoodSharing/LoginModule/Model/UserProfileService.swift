import Foundation
import SwiftyVK

struct UserProfileService: Codable {
    var name: String
    var surname: String
    var iconUrl: String
    var id: Int
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case surname = "last_name"
        case iconUrl = "photo_200"
        case id
        case city
    }
    
    init(name: String, surname: String, iconUrl: String, city: City, id: Int) {
        self.name = name
        self.surname = surname
        self.iconUrl = iconUrl
        self.city = city
        self.id = id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name    = try! container.decode(String.self, forKey: .name)
        self.surname = try! container.decode(String.self, forKey: .surname)
        self.iconUrl = try! container.decode(String.self, forKey: .iconUrl)
        self.id = try! container.decode(Int.self, forKey: .id)
        self.city = try! container.decode(City.self, forKey: .city)
    }

}

struct City: Codable {
    let id: Int
    let title: String
}

