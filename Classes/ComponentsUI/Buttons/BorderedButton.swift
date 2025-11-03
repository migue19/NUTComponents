import UIKit

class BorderedButton: UIButton {
    
    init(title: String, fontSize: CGFloat = 14, color: UIColor = .white) {
        super.init(frame: .zero)
        setupView(title: title, fontSize: fontSize, color: color)
    }
    
    func setupView(title: String, fontSize: CGFloat = 14, color: UIColor = .white) {
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
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


