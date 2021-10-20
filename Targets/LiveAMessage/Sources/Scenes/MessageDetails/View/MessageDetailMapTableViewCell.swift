//
//  MessageDetailMapTableViewCell.swift
//  Akee
//
//  Created by Albert on 30/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem
import MapKit
import Networking

class MessageDetailMapTableViewCell: UITableViewCell, ViewCode {

    lazy var mapView: MapView = {
        let view = MapView()
        view.isZoomEnabled = true
        return view
    }()

    func fill(with location: Location) {
        configureViews()
        let clLocation = CLLocation(latitude: location.lat, longitude: location.lon)
        let region = MKCoordinateRegion(center: clLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)

        let annotation = MKPointAnnotation()
        annotation.coordinate = clLocation.coordinate
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }

    func buildHierarchy() {
        addSubview(mapView)
    }

    func setupConstraints() {
        mapView.height(200)
        mapView.edgesToSuperview()
    }

    func configureViews() {
        buildHierarchy()
        setupConstraints()
    }
}
