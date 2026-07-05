
import UIKit
import SnapKit

final class MenuController: UIViewController {
    
    private let productService = ProductServiсe.init()
    private let categoryService = CategoryService.init()
    //private let ingredientService = IngredientService()
    private let bannerService = BannerServise.init()
    private let storyService = StoryService.init()
    
    private let ingredientSerivce = IngredientService()
    
    
    private var stories: [Story] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var categories: [Category] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
   
    private var ingridients: [Ingridient] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var banners: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var supplements: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        //tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.reuseId)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseId)
        tableView.register(StoryCell.self, forCellReuseIdentifier: StoryCell.reuseId)
        tableView.register(BasketAdditionCell.self, forCellReuseIdentifier: BasketAdditionCell.reuseId)
        
        //tableView.register(DecriptionCell.self, forCellReuseIdentifier: description.reuseId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        fetchProducts()
        fetchIngredients()
        fetchCategories()
        fetchBanners()
        fetchStories()
        
    }
    
 
}

//MARK: - Business Logic
extension MenuController {
    private func fetchProducts() {
        productService.fetchProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                print("Ошибка загрузки продуктов: \(error)")
            }
        }
    }
    
    private func fetchIngredients() {
        ingredientSerivce.fetchIngridients { [weak self] reuslt in
            
            guard let self = self else { return }
            switch reuslt {
            case .success(let ingridients):
                self.ingridients = ingridients
            case .failure(let error):
                print("Ошибка загрузки ингридиентов: \(error)")
            }
            
        }
    }
    private func fetchCategories() {
        categoryService.fetchCategories(completion: { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.categories = categories
            case .failure(let error):
                print("Ошибка загрузки категорий: \(error)")
            }
        })
    }
    private func fetchBanners() {
        bannerService.fetchBanners(completion: { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let banners):
                self.banners = banners
            case .failure(let error):
                print("Ошибка загрузки баннеров: \(error)")
            }
        })
    }
    
    private func fetchStories() {
        storyService.fetchStories { [weak self] result in
            
            guard let self = self else {return}
            switch result {
            case .success(let stories):
                self.stories = stories
            case .failure(let error):
                print("Ошибка загрузки строисов: \(error)")
            }
        
        }
    }
    
}


//MARK: - Setup UI
extension MenuController {
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

//MARK: - TableView datasource
extension MenuController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let menuSection = MenuSections(rawValue: section) else { return 0 }
        
        switch menuSection {
    
        case .stories, .banners, .categories:
            return 1
     
        case .products:
            return products.count
        }
    }
    
    enum MenuSections: Int, CaseIterable {
        case stories = 0
        case banners = 1
        case categories = 2
        case products = 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //.stories <- 0
        guard let menuSection = MenuSections(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch menuSection {
        case .stories:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryCell.reuseId, for: indexPath) as! StoryCell
            cell.update(with: self.stories)
            return cell
            
        case .banners:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.reuseId, for: indexPath) as! BannerCell
            cell.update(self.banners)
            return cell
            
        case .categories:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
            cell.update(self.categories)
            return cell
            
        case .products:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
            let product = products[indexPath.row]
            cell.update(product)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailController(index: indexPath.row)
    }
    
}

extension MenuController {
    private func navigateToDetailController(index: Int) {
        let product = products[index]
        let detailController = DetailProductController()
        detailController.update(product)
        present(detailController, animated: true)
    }
}
