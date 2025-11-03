//
//  TrainingCardMapView.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 19/08/25.
//
import UIKit
import MapKit
// MARK: - Tarjeta de entrenamiento
final class TrainingCardMapView: UIView, MKMapViewDelegate {
    // Datos
    struct Model {
        let title: String           // “20 ene 2025 – Plan 5K”
        let distanceKm: Double      // 12.40
        let paceMinPerKm: String    // "05:31"
        let timeHHmmss: String      // "1:20:23"
        let polyline: [CLLocationCoordinate2D] // ruta para el mapa
    }
    
    // Subvistas
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .semibold)
        //l.textColor = UIConstantsActivity.text
        return l
    }()
    private lazy var metricsStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [metric(distanceLabel, "Distancia"),
                                               metric(ritmoLabel, "Ritmo m/km"),
                                               metric(timeLabel, "Tiempo")])
        s.axis = .horizontal
        s.distribution = .fillEqually
        return s
    }()
    private func metric(_ valueLabel: UILabel, _ caption: String) -> UIStackView {
        let cap = UILabel()
        cap.text = caption
        cap.font = .systemFont(ofSize: 11, weight: .regular)
        //cap.textColor = UIConstantsActivity.sub
        valueLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        //valueLabel.textColor = UIConstantsActivity.text
        let v = UIStackView(arrangedSubviews: [valueLabel, cap])
        v.axis = .vertical
        v.spacing = 2
        return v
    }
    private let distanceLabel = UILabel()
    private let ritmoLabel = UILabel()
    private let timeLabel = UILabel()
    
    // Mapa (puedes cambiar por una UIImageView con snapshot si prefieres)
    private lazy var mapView: MKMapView = {
        let m = MKMapView()
        m.isUserInteractionEnabled = false
        m.layer.cornerRadius = 12
        m.layer.masksToBounds = true
        m.delegate = self
        return m
    }()
    
    // Contenedor
    private lazy var container: UIStackView = {
        let s = UIStackView(arrangedSubviews: [titleLabel, metricsStack, mapView])
        s.axis = .vertical
        s.spacing = 8
        return s
    }()
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layer.cornerRadius = 12
        setupLayout()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupLayout() {
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        mapView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    func configure(_ model: Model) {
        titleLabel.text = model.title
        distanceLabel.text = String(format: "%.2f kms", model.distanceKm)
        ritmoLabel.text = model.paceMinPerKm
        timeLabel.text = model.timeHHmmss
        
        mapView.removeOverlays(mapView.overlays)
        if !model.polyline.isEmpty {
            let line = MKPolyline(coordinates: model.polyline, count: model.polyline.count)
            mapView.addOverlay(line)
            mapView.setVisibleMapRect(line.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: false)
        }
    }
    
    // MKMapViewDelegate para pintar la ruta verde
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let r = MKPolylineRenderer(overlay: overlay)
        r.lineWidth = 6
        r.strokeColor = UIColor.systemGreen
        return r
    }
}
