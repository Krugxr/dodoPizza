import UIKit

final class ProductBasketCell: UITableViewCell {
    static let reuseId = "ProductBasketCell"
    private var nameLabel: UILabel = {
        var label = UILabel.init()
        label.text = "Пепперони"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var basketImageView: UIImageView = {
        var imageView = UIImageView.init(image: UIImage.init(named: "pepperoni"))
        return imageView
    }()
    
    private var descriptionLabel: UILabel = {
        var descriptionLabel = UILabel.init()
        descriptionLabel.text = "30 см, традиционное"
        return descriptionLabel
    }()
    
    private var priceLabel: UILabel = {
        var label = UILabel.init()
        label.text = "1 099 Р"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var changeButton: UIButton = {
        var button = UIButton.init()
        button.setTitle("Изменить", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    
    
    private lazy var stepperView = BasketCustomStepper()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(basketImageView)
        contentView.addSubview(stepperView)
        contentView.addSubview(changeButton)
        
    }
    
    private func setupConstraints() {
        basketImageView.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).offset(6)
            make.width.height.equalTo(100)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(basketImageView.snp.bottom).offset(6)
            make.left.bottom.equalTo(contentView).inset(6)
        }
        
        stepperView.snp.makeConstraints { make in
            make.right.bottom.equalTo(contentView).inset(6)
        }
        changeButton.snp.makeConstraints { make in
            make.right.equalTo(stepperView.snp.left).offset(-6)
            make.bottom.equalTo(contentView).inset(6)
            make.centerY.equalTo(stepperView)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.right.equalTo(contentView)
            make.left.equalTo(basketImageView.snp.right).offset(6)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.equalTo(nameLabel)
            make.right.equalTo(contentView).inset(6)
        }
        
    }
    
    private func setupStepper() {
        stepperView.addTarget(self, action: #selector(stepperChangedValueAction), for: .valueChanged)
    }
    @objc private func stepperChangedValueAction(sender: BasketCustomStepper) {
        print(sender)
        print(sender.currentValue)
    }
    
    func update(_ product: Product) {
        print(product)
        nameLabel.text = product.name
        descriptionLabel.text = product.detail
        priceLabel.text = String(product.price)
        basketImageView.image = UIImage.init(named:  product.image)
        stepperView.currentValue = product.count
        stepperView.currentStepValueLabel.text = String(product.count)
    }
}
