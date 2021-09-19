//
//  MapViewController.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem

class MapViewController: UIViewController {

    let viewModel = MapViewModel()

    let headerView = MapHeaderView()

    let mapView = MapView()

    override func viewDidLoad() {
        view.backgroundColor = .white
        self.mapView.bind(viewModel: viewModel)
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    func buildHierarchy() {
        view.addSubview(mapView)
        view.addSubview(headerView)
    }
    func setupConstraints() {
        mapView.setupConstraints()
        headerView.setupConstraints()
    }

    func configureViews() {
        headerView.rightButtonAction = addMessage
        headerView.leftButtonAction = showCloseMessages
    }
}

extension MapViewController {
    func addMessage() {
        let controller = AddMessageViewController(viewModel: AddMessageViewModel())
        controller.modalPresentationStyle = .formSheet
        present(controller, animated: true, completion: nil)
    }

    func showCloseMessages() {
        let closeMessagesViewModel = CloseMessagesViewModel(messages: viewModel.messages)
        let controller = CloseMessagesViewController(viewModel: closeMessagesViewModel)
        let navController = UINavigationController(rootViewController: controller)

        navController.modalPresentationStyle = .overFullScreen
        present(navController, animated: true)
    }
}
