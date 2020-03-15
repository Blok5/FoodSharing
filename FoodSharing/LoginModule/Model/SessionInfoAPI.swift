import Foundation

struct SessionInfoAPI: Codable {
    var expiresIn: String
    var accessToken: String
    var email: String
    var userId: String
    
    enum CodingKeys: String, CodingKey {
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case email
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.expiresIn = try! container.decode(String.self, forKey: .expiresIn)
        self.accessToken = try! container.decode(String.self, forKey: .accessToken)
        self.email = try! container.decode(String.self, forKey: .email)
        self.userId = try! container.decode(String.self, forKey: .userId)
    }
}
