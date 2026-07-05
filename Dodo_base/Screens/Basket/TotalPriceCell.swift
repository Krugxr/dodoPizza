import UIKit


class TotalPriceCell: UITableViewCell {
    static let reuseId = "TotalPriceCell"
    var nameLabel: UILabel = {
        var label = UILabel.init()
        label.text = "2 товара на 1 668 рублей"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(6)
            make.top.bottom.equalTo(contentView).inset(20)
        }
        
    }
}
