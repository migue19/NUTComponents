//
//  CardProgressView.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 27/06/25.
//
import UIKit
class CardProgressView: UIView {
    lazy var cardProgressTitle: UILabel = {
        let label = UILabel()
        label.text = "5K"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var segmentedProgressBar: SegmentedProgressBar = {
        let progressBar = SegmentedProgressBar()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    lazy var weekInfoView: InfoView = {
        let view = InfoView(imageName: "ic_calendar_info", text: "Semana: 1 de 4")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var sessionInfoView: InfoView = {
        let view = InfoView(imageName: "ic_run_shoes", text: "Sesiones: 5 esta semana")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var completeInfoView: InfoView = {
        let view = InfoView(imageName: "ic_complete", text: "Completados: 1 de 5 esta semana")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubviews(cardProgressTitle, segmentedProgressBar, weekInfoView, sessionInfoView, completeInfoView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardProgressTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            cardProgressTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardProgressTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            segmentedProgressBar.topAnchor.constraint(equalTo: cardProgressTitle.bottomAnchor, constant: 20),
            segmentedProgressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segmentedProgressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            weekInfoView.topAnchor.constraint(equalTo: segmentedProgressBar.bottomAnchor, constant: 20),
            weekInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weekInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            sessionInfoView.topAnchor.constraint(equalTo: weekInfoView.bottomAnchor, constant: 20),
            sessionInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sessionInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            completeInfoView.topAnchor.constraint(equalTo: sessionInfoView.bottomAnchor, constant: 20),
            completeInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            completeInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ self.addSubview($0) })
    }
}
