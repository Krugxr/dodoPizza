import Foundation

class DI {
    let profileDataService: ProfileDataService
    let supplementsService: SupplementsService
    let storageService: StorageService
    let storyService: StoryService
    let bannerSevice: BannerServise
    let ingridientService: IngredientService
    let productService: ProductServiсe
    let categoryService: CategoryService
    
    let screenFactory: ScreenFactory
    
    init() {
        
        profileDataService = ProfileDataService()
        
        supplementsService = SupplementsService()
        storageService = StorageService()
        storyService = StoryService()
        bannerSevice = BannerServise()
        ingridientService = IngredientService()
        productService = ProductServiсe()
        categoryService = CategoryService()
        
        screenFactory = ScreenFactory()
        screenFactory.di = self
    }
}

class ScreenFactory {
    weak var di: DI!
    
    func makeMenuScreen() -> MenuController {
        
        let menuVC = MenuController.init(
            productService: di.productService,
            categoryService: di.categoryService,
            bannerService: di.bannerSevice,
            storyService: di.storyService,
            ingredientSerivce: di.ingridientService)
        
        return menuVC
    }
    
    func makeProfileScreen() -> ProfileController {
        let profileVC = ProfileController.init(profileService: di.profileDataService)
        
        return profileVC
    }
    
    func makeDetailProductScreen(_ product: Product) -> DetailProductController {
        let detailProductVC = DetailProductController(ingredientService: di.ingridientService, storageService: di.storageService)
        
        detailProductVC.update(product)
        
        return detailProductVC
    }
    
    func makeBasketScreen() -> BasketController {
        let basketVC = BasketController.init(supplementsService: di.supplementsService, storageService: di.storageService)
        
        return basketVC
    }
    
    
}
