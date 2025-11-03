//
//  CustomSegmentControl.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 01/04/25.
//
import UIKit

class CustomSegmentedControl: UIView {
    private let stackView = UIStackView()
    private let indicatorView = UIView()
    
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0
    
    var items: [String] = [] {
        didSet {
            configureButtons()
        }
    }
    
    var selectedSegmentIndex: Int {
        return selectedIndex
    }
    
    var onSegmentChange: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        indicatorView.backgroundColor = .green
        indicatorView.layer.cornerRadius = 2
        addSubview(indicatorView)
    }
    
    private func configureButtons() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        for (index, title) in items.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(index == selectedIndex ? .green : .white, for: .normal)
            //button.titleLabel?.font = UIFont.Moderat.regular.font(size: 15)
            button.tag = index
            button.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        updateIndicatorPosition(animated: false)
    }
    
    @objc private func segmentTapped(_ sender: UIButton) {
        let index = sender.tag
        selectSegment(index: index, animated: true)
    }
    
    func selectSegment(index: Int, animated: Bool) {
        selectedIndex = index
        buttons.enumerated().forEach { (i, button) in
            button.setTitleColor(i == index ? .green : .white, for: .normal)
        }
        
        updateIndicatorPosition(animated: animated)
        onSegmentChange?(index)
    }
    
    private func updateIndicatorPosition(animated: Bool) {
        guard selectedIndex < buttons.count else { return }
        
        let selectedButton = buttons[selectedIndex]
        let indicatorFrame = CGRect(
            x: selectedButton.frame.origin.x,
            y: bounds.height - 3,
            width: selectedButton.frame.width,
            height: 3
        )
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.indicatorView.frame = indicatorFrame
            }
        } else {
            indicatorView.frame = indicatorFrame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateIndicatorPosition(animated: false)
    }
}
