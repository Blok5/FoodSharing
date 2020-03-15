import UIKit
import SwiftyVK

var vkDelegateReference : SwiftyVKDelegate?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        vkDelegateReference = VKDelegateExample()
        return true
    }
    
    func application(
        _ application: UIApplication,
        open url: URL,
        sourceApplication: String?,
        annotation: Any
    ) -> Bool {
        VK.handle(url: url, sourceApplication: sourceApplication)
        return true
    }
}

