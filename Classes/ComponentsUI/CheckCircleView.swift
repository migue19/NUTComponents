//
//  CheckCircleView.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 22/08/25.
//
import UIKit
// MARK: - Check circular
final class CheckCircleView: UIView {
    private let ring = CAShapeLayer()
    private lazy var checkView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "checkmark"))
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .black
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.addSublayer(ring)
        addSubview(checkView)
        checkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkView.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            checkView.heightAnchor.constraint(equalTo: checkView.widthAnchor)
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(ovalIn: bounds.insetBy(dx: 1.5, dy: 1.5))
        ring.path = path.cgPath
        ring.fillColor = UIColor.clear.cgColor
        ring.strokeColor = UIColor.black.cgColor
        ring.lineWidth = 3
    }
}
