import UIKit
import SnapKit

class StoryCell: UITableViewCell {
    
    var stories: [Story] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    static let reuseId = "StoryCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 110, height: 150)
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(StoryCollectionCell.self, forCellWithReuseIdentifier: StoryCollectionCell.reuseId)
        cv.delegate = self
        cv.dataSource = self
        return cv
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
    
    func update(with stories: [Story]) {
        self.stories = stories
    }
}

// MARK: - CollectionView
extension StoryCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StoryCollectionCell.reuseId,
            for: indexPath
        ) as? StoryCollectionCell else {
            return UICollectionViewCell()
        }
        
        let story = stories[indexPath.item]
        cell.update(story)
        return cell
    }
}
