//
//  LocationView.swift
//  RandomUsers
//
//  Created by Илья Салей on 2.08.25.
//

import UIKit
import GoogleMaps

private struct Constants {
    static let CLOSE_BUTTON_BORDER: CGFloat = 40
}

public final class LocationView: UIView {
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let crossImage = UIImage(systemName: "xmark")
        button.setImage(crossImage, for: .normal)
        return button
    }()
    private let mapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    public init(
        latitude: Double,
        longitude: Double,
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        let camera = GMSCameraPosition.camera(
            withLatitude: latitude,
            longitude: longitude,
            zoom: 6
        )
        mapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
        marker.title = "User location"
        marker.snippet = "Lat: \(latitude), Lon: \(longitude)"
        marker.map = mapView
        
        backgroundColor = .white
        layer.isDoubleSided = false
        setupActions()
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SETUP HELPERS
extension LocationView {
    
    private func setupActions() {
        closeButton.addTarget(
            self,
            action: #selector(closeButtonWasPressed),
            for: .touchUpInside
        )
    }
}

// MARK: - LAYOUT HELPERS
extension LocationView {
    
    private func layoutElements() {
        layoutCloseButton()
        layoutMapView()
    }
    
    private func layoutCloseButton() {
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            closeButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            closeButton.heightAnchor.constraint(
                equalToConstant: Constants.CLOSE_BUTTON_BORDER
            ),
            closeButton.widthAnchor.constraint(
                equalToConstant: Constants.CLOSE_BUTTON_BORDER
            )
        ])
    }
    
    private func layoutMapView() {
        addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor,
                constant: 40
            ),
            mapView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            mapView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            mapView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}

// MARK: - @OBJC METHODS
extension LocationView {
    
    @objc private func closeButtonWasPressed() {
        removeFromSuperview()
    }
}
