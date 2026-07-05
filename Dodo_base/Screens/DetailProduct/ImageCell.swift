import UIKit

final class ImageCell: UITableViewCell {
    static let reuseId = "ImageCell"
    
    private var photoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = .init(named: "default")
        return imageView
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
        contentView.addSubview(photoImageView)
        
    }
    
    private func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.width.equalTo(350)
        }
    }
    func update(_ product: Product) {
        photoImageView.image = UIImage(named: product.image)
    }
}
