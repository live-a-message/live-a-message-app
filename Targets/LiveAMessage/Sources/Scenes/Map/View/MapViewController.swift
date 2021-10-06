//
//  MapViewController.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import MapKit
import DesignSystem
import Networking

class MapViewController: UIViewController {

    let viewModel = MapViewModel()

    let mainView = MainMapView()

    weak var coordinator: Coordinator?

    override func viewDidLoad() {
        view.backgroundColor = .white
        self.mainView.bind(viewModel: viewModel)
        buildHierarchy()
        setupConstraints()
        configureViews()

        let coordinateRegion = MKCoordinateRegion(
            center: viewModel.currentLocation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000)
        self.mainView.mapView.setRegion(coordinateRegion, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserData.shared.agreeWithTerms == false {
            present(TermsViewController(), animated: true)
        }
    }

    func buildHierarchy() {
        view.addSubview(mainView)
    }
    func setupConstraints() {
        mainView.setupConstraints()
    }

    func configureViews() {
        mainView.headerView.rightButtonAction = addMessage
        mainView.headerView.leftButtonAction = showCloseMessages
        mainView.didTapPin = didTapMessagePin(_:)
        let circle = MKCircle(
            center: viewModel.currentLocation.coordinate,
            radius: viewModel.radius
        )
        mainView.mapView.addOverlay(circle)
    }
}

extension MapViewController {
    func addMessage() {
        coordinator?.showAddMessage()
    }

    func showCloseMessages() {
        coordinator?.showCloseMessages()
    }

    func didTapMessagePin(_ annotation: MKAnnotation?) {
        guard let pointAnnotation = annotation as? MKPointAnnotation,
              let message = viewModel.annotations[pointAnnotation] else { return }

        coordinator?.showMessageDetails(with: message, fromPin: true)
    }
}
