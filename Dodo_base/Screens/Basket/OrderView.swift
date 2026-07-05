import UIKit


class OrderView: UIView {
    var priceButton: UIButton = {
        var button = UIButton.init()
        button.setTitle("Оформить за 500 Р", for: .normal)
        button.setTitleColor(.white, for: .normal)

        button.layer.cornerRadius = 25.0
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
    func setupViews() {
        self.backgroundColor = .white
        self.addSubview(priceButton)
    }
    
    func setupConstraints() {
        priceButton.snp.makeConstraints { make in
            make.top.left.right.equalTo(self).inset(20)
            make.height.equalTo(50)
            //make.bottom.equalTo(self).inset(40)
        }
    }
}
