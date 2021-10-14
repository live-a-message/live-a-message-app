//
//  MapView.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 14/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import MapKit
import DesignSystem
import TinyConstraints
import Networking

class MapView: MKMapView {

    var didTapPin: ((MKAnnotation?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        self.isZoomEnabled = true
        self.tintColor = AKColor.mainRed
        self.showsUserLocation = true
        self.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {
        self.edgesToSuperview()
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = AKColor.mainRed
        circleRenderer.alpha = 0.08
        return circleRenderer
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            let image = AkeeAsset.markerFill.image.withRenderingMode(.alwaysTemplate)
            annotationView?.image = image
            annotationView?.tintColor = AKColor.mainRed
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        didTapPin?(view.annotation)
    }
}
