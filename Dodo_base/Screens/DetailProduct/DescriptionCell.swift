import UIKit


//UITableViewCell это объект ячейки UIView её нет в папках, это абстрактно

class DescriptionCell: UITableViewCell {
    static let reuseId = "DecriptionCell"
    var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Маргаритта"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
        
    }()
    
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Пицца с томатами, итаальянскими травами и моцареллой"
        label.textColor = .black
        label.numberOfLines = 0
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
        contentView.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.right.left.equalTo(contentView).inset(6)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.right.left.bottom.equalTo(contentView).inset(6)
        }
    }
}


