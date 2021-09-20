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

    let mainView = MainMapView()

    override func viewDidLoad() {
        view.backgroundColor = .white
        self.mainView.bind(viewModel: viewModel)
        buildHierarchy()
        setupConstraints()
        configureViews()
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
