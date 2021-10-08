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

    let viewModel: MapViewModelProtocol
    let mainView = MainMapView()
    weak var coordinator: Coordinator?

    init(viewModel: MapViewModelProtocol = MapViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        buildHierarchy()
        setupConstraints()
        configureViews()
        mainView.bind(viewModel: viewModel)
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
