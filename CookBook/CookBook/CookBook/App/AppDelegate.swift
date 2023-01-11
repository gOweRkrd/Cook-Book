import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var favoriteRecipes: [CuisineRecipe] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 1.0)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        setRootViewController()
        
        return true
    }
    
    private func setRootViewController() {
        let viewController = FirstScreenViewController()
        let navController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navController
    }
}
