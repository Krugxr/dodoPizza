import UIKit


final class BannerCell: UITableViewCell {
    
    var onBannerCellTap: ((Product)->())?
    
    private var banners: [Product] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var nameLabel: UILabel = {
        var label = UILabel.init()
        label.text = "Часто заказывают"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()

    static let reuseId = "BannerCell"
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 240, height: 130)
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(BannerCollectionCell.self, forCellWithReuseIdentifier: BannerCollectionCell.reuseId)
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
        contentView.addSubview(collectionView)
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(150)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).offset(6)
        }
    }
    
    func update(_ banners: [Product]){
        self.banners = banners
    }
}

extension BannerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionCell.reuseId, for: indexPath) as! BannerCollectionCell
        
        let banner = banners[indexPath.item]
        
        cell.update(banner)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("->", indexPath)
        
        let banner = banners[indexPath.item]
        onBannerCellTap?(banner)
    }
}
    
/*
//declaration closure (obyavlenie)
var onBannerCellTap: ((Product)->())?

//call closure (vizov)
onBannerCellTap?(banner)

//realization closure (realization)

cell.onBannerCellTap = { banner in
    vc.navigateToScreen()
}

// declaration + realization
func bannerCellTap() {
}

//realization
bannerCelltap()
 */

