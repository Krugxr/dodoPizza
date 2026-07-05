import UIKit

class IngredientCollectionCell: UICollectionViewCell {
    
    static let reuseId = "IngredientCollectionCell"
    var ingridientImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "cheese")
        return imageView
    }()
    
    var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.text = "Сырный бортик"
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    var priceLabel: UILabel = {
        var priceLabel = UILabel()
        priceLabel.text = "205 ₽"
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return priceLabel
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ ingridient: Ingridient) {
        ingridientImageView.image = UIImage(named: ingridient.image)
        nameLabel.text = ingridient.name
        priceLabel.text = String(ingridient.price)+" ₽"
    }
    
    func setupViews() {
        contentView.addSubview(ingridientImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        ingridientImageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.width.equalTo(100)
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(ingridientImageView.snp.bottom)
            make.right.left.equalTo(contentView)
            
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.right.left.bottom.equalTo(contentView)
        }
    }
    
}


class IngredientsCell: UITableViewCell {
    var ingridients: [Ingridient] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    static let reuseId = "IngredientsCell"
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 110, height: 200)
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(IngredientCollectionCell.self, forCellWithReuseIdentifier: IngredientCollectionCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ ingridients: [Ingridient]) {
        self.ingridients = ingridients
    }
    
    func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(10)
            make.height.equalTo(850)
        }
        
    }
    
}

extension IngredientsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingridients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionCell.reuseId, for: indexPath) as! IngredientCollectionCell
        cell.update(ingridients[indexPath.item])
        return cell
    }
}
