//
//  Coordinator.swift
//  Akee
//
//  Created by Tales Conrado on 23/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
    func showLogin()
    func showLogout()
    func showMap()
    func showCloseMessages()
    func showAddMessage()
}

class MainCoordinator: Coordinator {
    let mapViewController = MapViewController()
    var rootViewController: UIViewController?

    func start() {
        if isUserLoggedIn() {
            rootViewController = mapViewController
            mapViewController.coordinator = self
        } else {
            // show login
        }
    }

    func showLogin() {

    }

    func showLogout() {

    }

    func showMap() {
        if let rootViewController = rootViewController as? MapViewController {
            rootViewController.dismiss(animated: true)
        }

//        if let rootViewController = rootViewController as? SignInViewController {
//            rootViewController = MapViewController()
//        }
    }

    func showCloseMessages() {
        let closeMessagesViewModel = CloseMessagesViewModel(messages: mapViewController.viewModel.messages)

        let controller = CloseMessagesViewController(viewModel: closeMessagesViewModel)
        let navController = UINavigationController(rootViewController: controller)

        navController.modalPresentationStyle = .overFullScreen
        mapViewController.present(navController, animated: true)
    }

    func showAddMessage() {
        let controller = AddMessageViewController(viewModel: AddMessageViewModel())
        mapViewController.viewModel.notificateChange()
        controller.handleDismiss = {
            self.mapViewController.viewModel.didUpdatedLocation()
        }
        controller.modalPresentationStyle = .formSheet
        mapViewController.present(controller, animated: true)
    }

    private func isUserLoggedIn() -> Bool {
        // check for loggedIn status in keychain maybe.
        // for now the user is always logged in
        return true
    }
}
