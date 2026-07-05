import UIKit

class StoryCollectionCell: UICollectionViewCell {
    
    static let reuseId = "StoryCollectionCell"
    var storyImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage.init(named: "story_1"))
        imageView.clipsToBounds = true              // ← Важно!
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(storyImageView)
        contentView.layer.shadowOpacity = 0
        contentView.layer.shadowRadius = 0
        contentView.backgroundColor = .clear
    }
    
    func setupConstraints() {
        storyImageView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(contentView)
        }
    }
    
    func update(_ story: Story) {
        storyImageView.image = UIImage.init(named: story.image)
    }
}
