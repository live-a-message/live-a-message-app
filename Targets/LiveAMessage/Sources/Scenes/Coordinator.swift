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
    func showMessageDetails(with message: Message)
}

class MainCoordinator: Coordinator {
    private let authService = SignInWithAppleAuthorization()
    private let messagesService = CloudKitMessagesService()
    private let loginViewController: LoginViewController
    private let mapViewController: MapViewController
    private let rootViewController: UINavigationController

    
    private var closeMessagesController: CloseMessagesViewController?
    private var window: UIWindow?

    init() {

        rootViewController = UINavigationController()
        mapViewController = MapViewController()
        loginViewController = LoginViewController(viewModel: LoginViewModel(service: authService))
        configureControllers()
    }

    private func configureControllers() {
        rootViewController.navigationBar.isHidden = true
        mapViewController.coordinator = self
        loginViewController.coordinator = self
        authService.delegate = loginViewController
    }

    func start(window: UIWindow?) {
        self.window = window
        if isUserLoggedIn() {
            rootViewController.setViewControllers([mapViewController], animated: false)
        } else {
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
        closeMessagesViewModel.coordinator = self
        closeMessagesController = CloseMessagesViewController(viewModel: closeMessagesViewModel)
        let navController = UINavigationController(rootViewController: closeMessagesController!)

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
    
    func showMessageDetails(with message: Message) {
        let detailsMessageViewModel = MessageDetailsViewModel(message: message)
        let detailsViewController = MessageDetailsViewController(viewModel: detailsMessageViewModel)
        
        closeMessagesController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }

    private func isUserLoggedIn() -> Bool {
        return UserData.shared.isLoggedIn
    }
}
