//
//  DayInfoView.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 27/06/25.
//
import UIKit

class DayInfoView: UIView {
    
    // MARK: - Subvistas
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        //label.font = .Moderat.bold.font(size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Descripción:"
        //label.font = .Moderat.bold.font(size: 10)
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        //label.font = .Moderat.regular.font(size: 10)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var durationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Duración:"
        //label.font = .Moderat.bold.font(size: 10)
        label.textColor = .white
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        //label.font = .Moderat.regular.font(size: 10)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Inicializador
    
    init(title: String, description: String, duration: String) {
        super.init(frame: .zero)
        backgroundColor = .black
        setupLayout()
        
        titleLabel.text = title
        descriptionLabel.text = description
        durationLabel.text = duration
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            descriptionTitleLabel,
            descriptionLabel,
            durationTitleLabel,
            durationLabel
        ])
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
