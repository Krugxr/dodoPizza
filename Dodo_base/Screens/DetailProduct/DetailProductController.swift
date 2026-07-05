import UIKit
import SwiftUI

final class DetailProductController: UIViewController {
    private let orderView = OrderView.init()
    private let ingredientService = IngredientService()
    private let storageService = StorageService()
 
    private var product: Product? {
        didSet {
            tableView.reloadData()
        }
    }
    private var ingridients: [Ingridient] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseId)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.reuseId)
        tableView.register(CharacteristicsCell.self, forCellReuseIdentifier: CharacteristicsCell.reuseId)
        tableView.register(IngredientsCell.self, forCellReuseIdentifier: IngredientsCell.reuseId)

        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupObservers()
        
        fetchIngridients()
    }
    
}

extension DetailProductController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseId, for: indexPath) as! ImageCell
            
            if let product {
                cell.update(product)
            }
            
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.reuseId, for: indexPath) as! DescriptionCell
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacteristicsCell.reuseId, for: indexPath) as! CharacteristicsCell
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.reuseId, for: indexPath) as! IngredientsCell
            cell.update(ingridients)
            return cell
        }
        
        return UITableViewCell()
    }
        
    
}

//MARK: - Setup UI
extension DetailProductController {
    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(orderView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        orderView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(120)
        }
    }
}

//MARK: - Business Logic
extension DetailProductController {
    private func fetchIngridients() {
        ingredientService.fetchIngridients { reuslt in
            switch reuslt {
            case .success(let ingridients):
                self.ingridients = ingridients
            case .failure(let error):
                print(error)
            }
            
        }
    }
    private func setupObservers() {
        orderView.priceButton.addTarget(nil, action: #selector(priceButtonTap), for: .touchUpInside)
    }
}

//MARK: - Eventelly Handing
extension DetailProductController {
    @objc
    private func priceButtonTap() {
        
        if let product {
            storageService.append(product)
            
        }
        print(storageService.retrieve())
    }
}

//MARK: - Public Methods
extension DetailProductController {
    func update(_ product: Product) {
        self.product = product
    }
    
}

//MARK: - 
