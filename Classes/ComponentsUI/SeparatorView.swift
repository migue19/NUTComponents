//
//  SeparatorView.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 19/10/25.
//

import UIKit

class SeparatorView: UIView {
    
    // MARK: - Properties
    
    private let leftLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rightLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "ó"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    convenience init(text: String = "ó", lineColor: UIColor = .lightGray, textColor: UIColor = .lightGray) {
        self.init(frame: .zero)
        textLabel.text = text
        leftLineView.backgroundColor = lineColor
        rightLineView.backgroundColor = lineColor
        textLabel.textColor = textColor
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubview(leftLineView)
        addSubview(textLabel)
        addSubview(rightLineView)
        
        NSLayoutConstraint.activate([
            // Left line
            leftLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftLineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftLineView.trailingAnchor.constraint(equalTo: textLabel.leadingAnchor, constant: -16),
            leftLineView.heightAnchor.constraint(equalToConstant: 1),
            
            // Text label
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            // Right line
            rightLineView.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 16),
            rightLineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightLineView.heightAnchor.constraint(equalToConstant: 1),
            
            // Height constraint for the container
            heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Public Methods
    
    func configure(text: String, lineColor: UIColor = .lightGray, textColor: UIColor = .lightGray, lineHeight: CGFloat = 1) {
        textLabel.text = text
        leftLineView.backgroundColor = lineColor
        rightLineView.backgroundColor = lineColor
        textLabel.textColor = textColor
        
        // Update line height constraints
        leftLineView.constraints.first(where: { $0.firstAttribute == .height })?.constant = lineHeight
        rightLineView.constraints.first(where: { $0.firstAttribute == .height })?.constant = lineHeight
    }
}
