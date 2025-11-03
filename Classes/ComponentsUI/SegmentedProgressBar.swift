//
//  SegmentedProgressBar.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 05/05/25.
//
import UIKit

class SegmentedProgressBar: UIView {
    
    private var segments: [UIView] = []
    private let segmentCount: Int
    private let activeIndex: Int
    
    init(segmentCount: Int = 6, activeIndex: Int = 0) {
        self.segmentCount = segmentCount
        self.activeIndex = activeIndex
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0..<segmentCount {
            let segment = UIView()
            segment.layer.cornerRadius = 2
            segment.backgroundColor = (i == activeIndex) ? .green : UIColor.systemGray4
            segments.append(segment)
            stackView.addArrangedSubview(segment)
        }
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    func updateActiveIndex(_ index: Int) {
        for (i, segment) in segments.enumerated() {
            segment.backgroundColor = (i == index) ? .green : UIColor.systemGray4
        }
    }
}
