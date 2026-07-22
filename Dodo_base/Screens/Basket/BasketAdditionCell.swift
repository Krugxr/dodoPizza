import UIKit


final class BasketAdditionCell: UITableViewCell {
    
    var onBasketCollectionTap: ((Product)->())?
    private var supplements: [Product] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    static let reuseId = "BasketAdditionCell"
        
    private var nameLabel: UILabel = {
        var label = UILabel.init()
        label.text = "Добавить к заказу?"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 120, height: 220)
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BasketAdditionCollectionCell.self, forCellWithReuseIdentifier: BasketAdditionCollectionCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
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
    
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.height.equalTo(300)
            make.left.right.bottom.equalTo(contentView)
        }
    }
    func update(with supplements: [Product]) {
        self.supplements = supplements
        
    }
    
}

extension BasketAdditionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return supplements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketAdditionCollectionCell.reuseId, for: indexPath) as! BasketAdditionCollectionCell
        cell.update(supplements[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("mclcdmldc", indexPath)
        
        let supplement = supplements[indexPath.item]

        onBasketCollectionTap?(supplement)
        

    }
    
    
}

