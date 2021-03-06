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

    let mapCamera: MKMapCamera = {
        let camera = MKMapCamera()
        camera.pitch = 45
        camera.altitude = 500
        camera.heading = 45
        return camera
    }()

    var didTapPin: ((MKAnnotation?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        self.camera = mapCamera
        self.isZoomEnabled = true
        self.tintColor = AKColor.mainRed
        self.showsUserLocation = true
        self.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsCompass = false
    }

    func setupConstraints() {
        self.edgesToSuperview()
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = AKColor.mainRed.withAlphaComponent(0.08)
        return circleRenderer
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = AkeeAsset.marker.image
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.image = AkeeAsset.marker.image
        didTapPin?(view.annotation)
        mapView.deselectAnnotation(view.annotation, animated: false)
    }

    public func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        let userView = mapView.view(for: mapView.userLocation)
        userView?.isUserInteractionEnabled = false
        userView?.isEnabled = false
        userView?.canShowCallout = false
    }
}
