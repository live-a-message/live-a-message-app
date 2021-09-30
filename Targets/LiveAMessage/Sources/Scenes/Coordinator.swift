//
//  Coordinator.swift
//  Akee
//
//  Created by Tales Conrado on 23/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import UIKit
import Networking

protocol Coordinator: AnyObject {
    func start(window: UIWindow?)
    func showLogin()
    func showLogout()
    func showMap()
    func showCloseMessages()
    func showAddMessage()
}

class MainCoordinator: Coordinator {
    private let authService = SignInWithAppleAuthorization()
    private let messagesService = CloudKitMessagesService()

    private let mapViewController: MapViewController
    private let rootViewController: UINavigationController

    private var window: UIWindow?

    init() {

        rootViewController = UINavigationController()
        mapViewController = MapViewController()

        configureControllers()
    }

    private func configureControllers() {
        rootViewController.navigationBar.isHidden = true
        mapViewController.coordinator = self
    }

    func start(window: UIWindow?) {
        self.window = window
        if isUserLoggedIn() {
            rootViewController.setViewControllers([mapViewController], animated: false)
        } else {
            let viewModel = LoginViewModel(service: authService)
            let loginViewController = LoginViewController(viewModel: viewModel, coordinator: self)
            authService.delegate = loginViewController
            rootViewController.setViewControllers([loginViewController], animated: false)
        }
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }

    func showLogin() {

    }

    func showLogout() {

    }

    func showMap() {
        rootViewController.setViewControllers([mapViewController], animated: true)
    }

    func showCloseMessages() {
        let closeMessagesViewModel = CloseMessagesViewModel(messages: mapViewController.viewModel.messages)

        let controller = CloseMessagesViewController(viewModel: closeMessagesViewModel)
        let navController = UINavigationController(rootViewController: controller)

        navController.modalPresentationStyle = .overFullScreen
        rootViewController.present(navController, animated: true)
    }

    func showAddMessage() {
        let controller = AddMessageViewController(viewModel: AddMessageViewModel())
        mapViewController.viewModel.notificateChange()
        controller.handleDismiss = {
            self.mapViewController.viewModel.didUpdatedLocation()
        }
        controller.modalPresentationStyle = .formSheet
        rootViewController.present(controller, animated: true)
    }

    private func isUserLoggedIn() -> Bool {
        return false
    }
}
