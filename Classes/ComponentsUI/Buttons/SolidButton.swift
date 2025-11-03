import UIKit

class SolidButton: UIButton {
    
    init(title: String, backgroundColor: UIColor = .systemBackground, fontSize: CGFloat = 14) {
        super.init(frame: .zero)
        setupView(title: title, backgroundColor: backgroundColor, fontSize: fontSize)
    }
    
    func setupView(title: String, backgroundColor: UIColor = .systemBackground, fontSize: CGFloat = 14) {
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        self.backgroundColor = backgroundColor
        titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}

