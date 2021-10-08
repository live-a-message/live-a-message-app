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
    func showMessageDetails(with message: Message, fromPin: Bool)
    func showReportMenu(with message: Message, on viewController: UIViewController)
    func showDeleteMenu(with message: Message, on viewController: UIViewController)
}

class MainCoordinator: Coordinator {
    private let authService = SignInWithAppleAuthorization()
    private let messagesService = CloudKitMessagesService()
    private let userService = CloudKitUserService()
    private let loginViewController: LoginViewController
    private let mapViewController: MapViewController
    private let rootViewController: UINavigationController

    private var closeMessagesController: CloseMessagesViewController?
    private var closeMessagesViewModel: CloseMessagesViewModel?
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
        closeMessagesViewModel = CloseMessagesViewModel(messages: mapViewController.viewModel.messages)
        closeMessagesViewModel?.coordinator = self
        closeMessagesController = CloseMessagesViewController(viewModel: closeMessagesViewModel!)
        let navController = UINavigationController(rootViewController: closeMessagesController!)

        navController.modalPresentationStyle = .overFullScreen
        rootViewController.present(navController, animated: true)
    }

    func showAddMessage() {
        let controller = AddMessageViewController(viewModel: AddMessageViewModel())
        mapViewController.viewModel.postNotificationUpdateLocation()
        controller.handleDismiss = {
            self.mapViewController.viewModel.fetchMessages()
        }

        controller.viewModel.didSaveMessage = { [weak self] message in
            self?.mapViewController.viewModel.addPin(message)
        }
        controller.modalPresentationStyle = .formSheet
        rootViewController.present(controller, animated: true)
    }

    func showMessageDetails(
        with message: Message,
        fromPin: Bool
    ) {
        let detailsMessageViewModel = MessageDetailsViewModel(message: message)
        let detailsViewController = MessageDetailsViewController(viewModel: detailsMessageViewModel)
        detailsViewController.coordinator = self

        if fromPin {
            let detailsNavigation = UINavigationController(rootViewController: detailsViewController)
            detailsNavigation.modalPresentationStyle = .overFullScreen
            detailsViewController.setCloseButton()
            rootViewController.present(detailsNavigation, animated: true, completion: nil)
        } else {
            closeMessagesController?.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }

    func showReportMenu(with message: Message, on viewController: UIViewController) {
        let reportViewModel = ReportViewModel(message: message, service: userService)
        let reportView = ReportView(viewModel: reportViewModel)
        reportView.showReportMenu(on: viewController)
    }

    func showDeleteMenu(with message: Message, on viewController: UIViewController) {
        let deleteViewModel = DeleteViewModel(message: message, service: messagesService)
        let deleteView = DeleteView(viewModel: deleteViewModel)
        deleteView.popScreen = popMessageDetailsAndRemove
        deleteView.showDeleteMenu(on: viewController)
    }

    private func popMessageDetailsAndRemove(message: Message) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let updatedMessages = self.mapViewController.viewModel.messages.filter({ $0.id != message.id })
            self.closeMessagesViewModel?.setupCells(messages: updatedMessages)
            self.closeMessagesController?.navigationController?.popToRootViewController(animated: true)
        }
    }

    private func isUserLoggedIn() -> Bool {
        #if DEBUG
            return true
        #else
            return UserData.shared.isLoggedIn
        #endif
    }
}
