import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = MainCoordinator()
        coordinator.start()
        window?.rootViewController = coordinator.rootViewController
        window?.makeKeyAndVisible()

        return true
    }

}
