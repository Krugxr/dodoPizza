import UIKit


final class BasketAdditionCollectionCell: UICollectionViewCell {
    static let reuseId = "BasketAdditionCollectionCell"
    
    private var containerView: UIView = {
        let view = UIView()
        
        // Основные настройки тени
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.12          // от 0.08 до 0.2 — обычно хватает
        view.layer.shadowOffset = CGSize(width: 0, height: 4)   // смещение вниз
        view.layer.shadowRadius = 8              // размытие тени
        
        // Важно!
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        
        // Дополнительно (рекомендуется)
        view.backgroundColor = .white
        view.layer.cornerRadius = 16             // если хочешь скруглённые углы вместе с тенью
        
        return view
    }()
    private var nameLabel: UILabel = {
        var label = UILabel.init()
        label.text = "Добрый Кола без сахара"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private var mountLabel: UILabel = {
        var label = UILabel.init()
        label.text = "0,5 л"
        label.textAlignment = .center
        return label
    }()
    
    private var additionImageView: UIImageView = {
        var image = UIImageView.init(image: .init(named: "pngtree-coca"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var priceButton: UIButton = {
        var button = UIButton.init()
        button.setTitle("145 Р", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //button.layer.borderWidth = 0.7
        //button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10.0
        button.backgroundColor = .orange
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product) {
        nameLabel.text = product.name
        mountLabel.text = "\(product.price) л"
        additionImageView.image = UIImage(named: product.image)
        priceButton.setTitle("\(product.price)", for: .normal)
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(mountLabel)
        contentView.addSubview(additionImageView)
        contentView.addSubview(priceButton)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(40)
            make.left.right.bottom.equalTo(4)
        }
        additionImageView.snp.makeConstraints { make in
            make.left.right.equalTo(containerView)
            make.top.equalTo(contentView)
            make.height.width.equalTo(100)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(additionImageView.snp.bottom).offset(6)
            make.left.right.equalTo(contentView)
        }
        mountLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.right.equalTo(contentView)
        }
        priceButton.snp.makeConstraints { make in
            make.top.equalTo(mountLabel.snp.bottom).offset(6)
            make.left.right.bottom.equalTo(containerView).inset(6)
        }
    }
    
}
