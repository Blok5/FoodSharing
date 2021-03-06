import SwiftyVK
import UIKit

final class VKDelegateExample: SwiftyVKDelegate {
    
    let appId = "7338418"
    let scopes: Scopes = [.email,.photos]
//    ;[.messages,.offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email]
    
    init() {
        VK.setUp(appId: appId, delegate: self)
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scopes
    }

    func vkNeedToPresent(viewController: VKViewController) {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if let rootController = keyWindow!.rootViewController {
            rootController.present(viewController, animated: true)
        }
     
    }
    
    func vkTokenCreated(for sessionId: String, info: [String : String]) {
        print("token created in session \(sessionId) with info \(info)")
    }
    
    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        print("token updated in session \(sessionId) with info \(info)")
    }
    
    func vkTokenRemoved(for sessionId: String) {
        print("token removed in session \(sessionId)")
    }
}
