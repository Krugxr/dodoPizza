import UIKit
extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.reuseId, for: indexPath) as! CategoryCollectionCell
        let categorie = self.categories[indexPath.item]
        cell.update(category: categorie)
        return cell
    }
}

final class CategoryCell: UITableViewCell {
    
    private var categories: [Category] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    static let reuseId = "CategoryCell"
    
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize.init(width: 60, height: 30)
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.reuseId)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).offset(6)
            make.height.equalTo(60)
        }
    }
    
    func update(_ categories:[Category]) {
        self.categories = categories
    }
    

}
