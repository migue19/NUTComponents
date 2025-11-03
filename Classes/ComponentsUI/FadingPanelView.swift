//
//  FadingPanelView.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 20/08/25.
//
import UIKit
// MARK: - Panel con desvanecido superior (mask gradient)
final class FadingPanelView: UIView {
    /// Altura (en puntos) del fade desde transparente→opaco en la parte superior.
    var fadeTopLength: CGFloat = 80 { didSet { setNeedsLayout() } }

    private let maskLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        layer.masksToBounds = true
        maskLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        maskLayer.locations = [0.0, 1.0]
        maskLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        maskLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)
        layer.mask = maskLayer
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSubviews() {
        super.layoutSubviews()
        // La parte superior arranca transparente y rápidamente pasa a opaca
        let h = bounds.height
        let fade = max(1, min(fadeTopLength, h))
        // Distribución de stops para que solo la franja `fade` sea transparente→opaca
        maskLayer.frame = bounds
        maskLayer.locations = [0.0, NSNumber(value: Float(fade / h))]
    }
}
