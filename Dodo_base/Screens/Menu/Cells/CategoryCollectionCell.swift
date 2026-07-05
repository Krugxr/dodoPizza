import UIKit


class CategoryCollectionCell: UICollectionViewCell {
    static let reuseId = "CategoryCollectionCell"
    var containerView: UIView = {
        var view = UIView.init()
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    var nameLabel: UILabel = {
        var label = UILabel.init()
        label.text = "Комбический невёебаться комбо "
        return label
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
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalTo(containerView).inset(10)
            make.top.bottom.equalTo(containerView).inset(6)
        }
        
    }
    
    func update(category: Category){
        nameLabel.text = category.name
    }
}
