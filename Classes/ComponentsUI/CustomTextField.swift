//
//  CustomTextField.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 14/02/25.
//
import UIKit

// Subclass UITextField to properly support right padding
class PaddedTextField: UITextField {
    var textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 10 // Add 10pt margin from right edge
        return rect
    }
}

class CustomTextField: UIView {
    
    // MARK: - TextFieldType Enum
    
    enum TextFieldType {
        case text
        case email
        case password
        
        var keyboardType: UIKeyboardType {
            switch self {
            case .email:
                return .emailAddress
            case .text, .password:
                return .default
            }
        }
        
        var isSecure: Bool {
            switch self {
            case .password:
                return true
            case .text, .email:
                return false
            }
        }
        
        var autocapitalizationType: UITextAutocapitalizationType {
            switch self {
            case .email, .password:
                return .none
            case .text:
                return .sentences
            }
        }
        
        var autocorrectionType: UITextAutocorrectionType {
            switch self {
            case .email, .password:
                return .no
            case .text:
                return .default
            }
        }
        
        var contentType: UITextContentType? {
            switch self {
            case .email:
                return .emailAddress
            case .password:
                return .password
            case .text:
                return nil
            }
        }
    }
    
    // MARK: - UI Components
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Eye button to toggle secure text visibility
    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .system)
        // Use UIButton.Configuration on iOS 15+ to set image and content insets without deprecation warnings
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            if let eyeImage = UIImage(systemName: "eye") {
                config.image = eyeImage
            }
            config.baseForegroundColor = .lightGray
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6)
            button.configuration = config
        } else {
            // Prefer SF Symbols, fallback to emoji
            if let eye = UIImage(systemName: "eye") {
                button.setImage(eye, for: .normal)
                button.tintColor = .lightGray
            } else {
                button.setTitle("👁", for: .normal)
                button.setTitleColor(.lightGray, for: .normal)
            }
            // keep using contentEdgeInsets on older iOS versions
            button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        }
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        // size for rightView
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        // accessibility
        button.accessibilityTraits = .button
        return button
    }()

    // Stored properties to manage rightView sizing
    private var rightContainer: UIView?
    private var isSecureField: Bool = false
    private let buttonSize: CGFloat = 40
    private let paddingFromButton: CGFloat = 50

    lazy var textField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Correo electrónico",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.rightViewMode = .always
        return textField
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),

            descriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Configure
    
    func configure(title: String, placeholder: String, type: TextFieldType, description: String? = nil, delegate: UITextFieldDelegate? = nil) {
        titleLabel.text = title
        textField.placeholder = placeholder
        textField.keyboardType = type.keyboardType
        textField.autocapitalizationType = type.autocapitalizationType
        textField.autocorrectionType = type.autocorrectionType
        textField.textContentType = type.contentType
        textField.isSecureTextEntry = type.isSecure
        textField.delegate = delegate
        descriptionLabel.text = description
        isSecureField = type.isSecure
        
        // Configure eye button if the field is secure (password)
        if type.isSecure {
            updateEyeImage()
            textField.rightViewMode = .always
            // Set internal right padding to prevent text from overlapping the eye button
            textField.textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: paddingFromButton + buttonSize)
            setNeedsLayout()
        } else {
            textField.textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            textField.rightView = nil
            textField.rightViewMode = .never
            rightContainer = nil
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Create or update the right container for secure fields
        if isSecureField {
            let height = max(buttonSize, textField.frame.height > 0 ? textField.frame.height : buttonSize)
            
            if rightContainer == nil {
                // Create the container for the first time
                let container = UIView(frame: CGRect(x: 0, y: 0, width: paddingFromButton + buttonSize, height: height))
                container.backgroundColor = .clear
                eyeButton.removeFromSuperview()
                container.addSubview(eyeButton)
                textField.rightView = container
                textField.rightViewMode = .always
                rightContainer = container
            }
            
            // Update container and button frames with current dimensions
            if let container = rightContainer {
                container.frame = CGRect(x: 0, y: 0, width: paddingFromButton + buttonSize, height: height)
                if eyeButton.superview != container {
                    eyeButton.removeFromSuperview()
                    container.addSubview(eyeButton)
                }
                // center vertically
                eyeButton.frame = CGRect(x: paddingFromButton, y: (height - buttonSize)/2, width: buttonSize, height: buttonSize)
            }
        }
    }

    @objc private func togglePasswordVisibility() {
        // Toggle secure text entry while keeping cursor position
        let wasFirstResponder = textField.isFirstResponder
        let selectedRange = textField.selectedTextRange
        textField.isSecureTextEntry.toggle()
        // Workaround to force the text field to refresh its secureTextEntry state
        let currentText = textField.text
        textField.text = nil
        textField.text = currentText
        // Restore selection
        if let range = selectedRange {
            textField.selectedTextRange = range
        }
        if wasFirstResponder {
            textField.becomeFirstResponder()
        }
        updateEyeImage()
    }

    private func updateEyeImage() {
        // When secure, show closed eye; when visible, show open eye
        let imageName = textField.isSecureTextEntry ? "eye.slash" : "eye"
        if #available(iOS 15.0, *) {
            var config = eyeButton.configuration ?? UIButton.Configuration.plain()
            if let img = UIImage(systemName: imageName) {
                config.image = img
            }
            config.baseForegroundColor = .lightGray
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6)
            eyeButton.configuration = config
        } else {
            if let closed = UIImage(systemName: "eye.slash"), let open = UIImage(systemName: "eye") {
                let image = textField.isSecureTextEntry ? closed : open
                eyeButton.setImage(image, for: .normal)
                eyeButton.tintColor = .lightGray
            } else {
                eyeButton.setTitle(textField.isSecureTextEntry ? "🔒" : "👁", for: .normal)
            }
        }
    }
}
