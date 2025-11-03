//
//  DateBadgeView.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 19/08/25.
//
import UIKit
// MARK: - Chip de fecha
final class DateBadgeView: UIView {
    private lazy var dayLabel: UILabel = {
        let l = UILabel()
        //l.font = .Urbane.boldItalic.font(size: 20)
        //l.textColor = UIConstantsActivity.text
        l.textAlignment = .center
        return l
    }()
    private lazy var monLabel: UILabel = {
        let l = UILabel()
        //l.font = .Moderat.regular.font(size: 14)
        //l.textColor = UIConstantsActivity.sub
        l.textAlignment = .center
        return l
    }()
    private lazy var stack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [dayLabel, monLabel])
        s.axis = .vertical
        s.alignment = .center
        s.spacing = 2
        return s
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = CalendarConstants.chip
        layer.cornerRadius = 10
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(date: Date, calendar: Calendar) {
        let d = calendar.component(.day, from: date)
        dayLabel.text = "\(d)"

        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "es_MX")
        fmt.dateFormat = "LLL" // abr, may, jun
        monLabel.text = fmt.string(from: date).uppercased()
    }

    func setDisabled(_ disabled: Bool) {
        alpha = disabled ? 0.4 : 1.0
    }
}
