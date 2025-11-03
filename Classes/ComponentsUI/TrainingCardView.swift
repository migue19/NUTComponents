//
//  TrainingCardView.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 03/07/25.
//
import UIKit
class TrainingCardView: UIView {
    // MARK: - Subvistas

    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        //label.font = .Moderat.bold.font(size: 13)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        //label.font = .Moderat.regular.font(size: 10)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private lazy var rightContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Inicializador

    init(image: UIImage?, title: String, subtitle: String) {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupLayout()

        leftImageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupLayout() {
        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 0

        rightContainerView.addSubview(textStack)
        textStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: rightContainerView.topAnchor, constant: 12),
            textStack.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor, constant: -12),
            textStack.bottomAnchor.constraint(equalTo: rightContainerView.bottomAnchor, constant: -12)
        ])

        let mainStack = UIStackView(arrangedSubviews: [leftImageView, rightContainerView])
        mainStack.axis = .horizontal
        mainStack.spacing = 0
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStack)

        NSLayoutConstraint.activate([
            leftImageView.widthAnchor.constraint(equalToConstant: 124),
            leftImageView.heightAnchor.constraint(equalToConstant: 114),
            
            rightContainerView.heightAnchor.constraint(equalTo: leftImageView.heightAnchor),

            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

