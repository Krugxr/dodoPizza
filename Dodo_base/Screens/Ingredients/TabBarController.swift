import UIKit

class TabBarController: UITabBarController {
    
    let menuController: MenuController = {
        
        let controller = di.screenFactory.makeMenuScreen()
        //let controller = MenuController()
        let tabItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(named: "house"))
        controller.tabBarItem = tabItem
        return controller
    }()
    
    let profileController: ProfileController = {
        //let controller = ProfileController()
        let controller = di.screenFactory.makeProfileScreen()
        //provate let controller: IProfileController
        let tabItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(named: "person"))
        controller.tabBarItem = tabItem
        return controller
    }()
    
    let ingridientsController: BasketController = {
      //  let controller = BasketController()
        
        let controller = di.screenFactory.makeBasketScreen()
        let tabItem = UITabBarItem(title: "", image: UIImage(systemName: "trash") , selectedImage: UIImage(systemName: "trash") )
        controller.tabBarItem = tabItem
        return controller
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apperance = UITabBarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.stackedLayoutAppearance.normal.iconColor = UIColor.green
        apperance.stackedLayoutAppearance.normal.iconColor = UIColor.red
        
        
        tabBar.standardAppearance = apperance
        tabBar.scrollEdgeAppearance = apperance
        
        viewControllers = [menuController,ingridientsController,profileController]
    }
    
    
    
    
}
