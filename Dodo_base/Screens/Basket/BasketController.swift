import UIKit

final class BasketController: UIViewController {
    private let orderView = OrderView.init()
    private let supplementsService = SupplementsService.init()
    private let storageService = StorageService.init()
    
    private var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var supplements: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView  = {
        var tableview = UITableView.init()
        tableview.register(TotalPriceCell.self, forCellReuseIdentifier: TotalPriceCell.reuseId)
        tableview.register(ProductBasketCell.self, forCellReuseIdentifier: ProductBasketCell.reuseId)
        tableview.register(BasketAdditionCell.self, forCellReuseIdentifier: BasketAdditionCell.reuseId)
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.backgroundColor = .white
        return tableview
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadProductsFromStorage()
        fetchSupplements()
    }
}

//MARK: - TableView Datasource
extension BasketController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let basketSeciton = BasketSections(rawValue: section) else { return 0 }
        
        switch basketSeciton {
        case .totalPrice:
            return 1
        case .productCell:
            return products.count
        case .additions:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return BasketSections.allCases.count
    }
    
    
    //BasketSection { totalPrice, productCell, additions}
    
    enum BasketSections: Int, CaseIterable {
        case totalPrice = 0
        case productCell = 1
        case additions = 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let basketSeciton = BasketSections(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch basketSeciton {
        case .totalPrice:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TotalPriceCell.reuseId, for: indexPath) as! TotalPriceCell
            return cell
            
        case .productCell:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductBasketCell.reuseId, for: indexPath) as! ProductBasketCell
            let product = products[indexPath.row]
            cell.update(product)
            return cell
        case .additions:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BasketAdditionCell.reuseId, for: indexPath) as! BasketAdditionCell
            
            cell.update(with: supplements)
            return cell
        }
    }
}

//MARK: - Setup UI
extension BasketController {
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(orderView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view)
            make.bottom.equalTo(view).inset(130)
        }
        //orderView.backgroundColor = .red
        orderView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(150)
        }
    }
}

//MARK: - Business Logic
extension BasketController {
    
    private func loadProductsFromStorage() {
        self.products = storageService.retrieve()
        // tableView.reloadData() не нужно — didSet сделает сам
    }
    
    private func fetchSupplements() {
        supplementsService.fetchSupplements { [weak self] result in   // ← [weak self]
            
            guard let self = self else { return }
                switch result {
                case .success(let supplements):
                    self.supplements = supplements
            
                    
                case .failure(let error):
                    print("Ошибка загрузки добавок: \(error)")
                }
            }
        }
    }
