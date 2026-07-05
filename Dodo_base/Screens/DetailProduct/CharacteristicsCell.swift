import UIKit


class CharacteristicsCell: UITableViewCell {
    
    static let reuseId = "CharacteristicsCell"
    var sizeSegment: UISegmentedControl = {
        var segment = UISegmentedControl.init(items: ["20 см", "25 см", "30 см", "35 см"])
        segment.selectedSegmentIndex = 1
        return segment
    }()
    
    var doughSegment: UISegmentedControl = {
        var segment = UISegmentedControl.init(items: ["Традиционное", "Тонкое"])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(sizeSegment)
        contentView.addSubview(doughSegment)
    }
    
    func setupConstraints() {
        sizeSegment.snp.makeConstraints { make in
            make.top.right.left.equalTo(contentView).inset(16)
        }
        doughSegment.snp.makeConstraints { make in
            make.top.equalTo(sizeSegment.snp.bottom).offset(16)
            make.right.left.bottom.equalTo(contentView).inset(16)
        }
    }
}
