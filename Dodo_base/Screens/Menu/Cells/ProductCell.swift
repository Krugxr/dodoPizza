import UIKit
import SnapKit

class ProductCell: UITableViewCell {
    
    static let reuseId = "ProductCell"
    
    private var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.applyShadow(cormerRadius: 10)
        return view
    }()
    
    var verticalStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Гавайская"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var detailLabel: UILabel = {
        var label = UILabel()
        label.text = "Тесто, Цыпленок, моцарелла, томатный соус"
        label.textColor = .darkGray
        label.numberOfLines = 2                    // максимум 2 строки
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // В свойствах класса
    var priceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange.withAlphaComponent(0.1)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor(red: 0.55, green: 0.27, blue: 0.07, alpha: 1.0), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 7, left: 18, bottom: 7, right: 18)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    // Слой для красивой диагональной линии
    private let strikeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.orange.cgColor
        layer.lineWidth = 1.7
        layer.fillColor = nil
        return layer
    }()
    
    var productImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "pizza")
        imageView.contentMode = .scaleAspectFill
        let width = UIScreen.main.bounds.width
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 0.40 * width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.40 * width).isActive = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("not detected")
    }
    
    struct Layout {
        static let offset = 16
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(detailLabel)
        
        // === Горизонтальный стек с ценами ===
        let priceStackView = UIStackView()
        priceStackView.axis = .horizontal
        priceStackView.spacing = 12
        priceStackView.alignment = .center
        
        priceStackView.addArrangedSubview(priceButton)
        priceStackView.addArrangedSubview(oldPriceLabel)
        
        verticalStackView.addArrangedSubview(priceStackView)   // или containerView, если без стека
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.top.right.equalTo(contentView).inset(12)
            make.bottom.equalTo(contentView).inset(8)
        }
        
        productImageView.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(10)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(128)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(containerView).inset(Layout.offset)
            make.left.equalTo(productImageView.snp.right).offset(Layout.offset)
        }
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(productImageView.snp.right).offset(16)
            make.right.equalTo(containerView).offset(-16)
        }
        priceButton.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(16)
        }
    }
    
    func update(_ product: Product) {
        nameLabel.text = product.name
        detailLabel.text = product.detail
        productImageView.image = UIImage(named: product.image)
        
        priceButton.setTitle("\(product.price) ₽", for: .normal)
        
        let oldPriceText = "\(product.oldPrice) ₽"
        oldPriceLabel.text = oldPriceText
        
        // Удаляем предыдущую линию
        strikeLayer.removeFromSuperlayer()
        
        // Более крутая диагональ
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let bounds = self.oldPriceLabel.bounds
            let path = UIBezierPath()
            
            // Более крутой угол
            path.move(to: CGPoint(x: 0, y: bounds.height * 0.75))
            path.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.25))
            
            self.strikeLayer.path = path.cgPath
            self.oldPriceLabel.layer.addSublayer(self.strikeLayer)
        }
    }
}
