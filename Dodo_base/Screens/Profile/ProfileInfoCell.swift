import UIKit

final class ProfileInfoCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    static let reuseId = "ProfileInfoCell"
    private var profileData: [ProfileData] = [] {
        didSet {
            collectionView.reloadData()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionCell.reuseId, for: indexPath) as! ProfileCollectionCell
        //let cell = UICollectionViewCell()
        cell.update(profileData[indexPath.row])
        return cell
    }
    
    
    private lazy var collectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0      // горизонтальное расстояние между ячейками
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 150, height: 200)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProfileCollectionCell.self, forCellWithReuseIdentifier: ProfileCollectionCell.reuseId)
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
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(200)
        }
    }
    func update(with profileData: [ProfileData]) {
        self.profileData = profileData
        
    }
}
