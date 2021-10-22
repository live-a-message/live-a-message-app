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
import DesignSystem

protocol Coordinator: AnyObject {
    func start(window: UIWindow?)
    func showLogin()
    func showLogout()
    func showMap()
    func showAddMessage()
    func didFetchMessages(messages: [Message])
    func showMessageDetails(with message: Message, fromPin: Bool)
    func showReportMenu(with message: Message, on viewController: UIViewController)
    func showDeleteMenu(with message: Message, on viewController: UIViewController)
    func doLogoff()
}

class MainCoordinator: Coordinator {
    private let authService = SignInWithAppleAuthorization()
    private let messagesService = CloudKitMessagesService()
    private let userService = CloudKitUserService()
    private let loginViewController: LoginViewController
    private let profileViewController = ProfileViewController()
    private let mapViewController: MapViewController
    private let onboardingViewController = OnboardingPageViewController()
    private let tabBarController: UITabBarController

    private var closeMessagesController: CloseMessagesViewController?
    private var closeMessagesViewModel: CloseMessagesViewModel?
    private var window: UIWindow?

    init() {
        mapViewController = MapViewController()
        loginViewController = LoginViewController(viewModel: LoginViewModel(service: authService))
        tabBarController = UITabBarController()
        configureControllers()
        configureTabBar()
    }

    private func configureControllers() {
        mapViewController.coordinator = self
        loginViewController.coordinator = self
        onboardingViewController.coordinator = self
        profileViewController.coordinator = self
        authService.delegate = loginViewController
    }

    func start(window: UIWindow?) {
        self.window = window
        if !isUserLoggedIn() {
            let navigation = UINavigationController(rootViewController: onboardingViewController)
            navigation.modalPresentationStyle = .fullScreen
            mapViewController.present(navigation, animated: false)
        }

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func showLogin() {
        let navigation = UINavigationController(rootViewController: onboardingViewController)
        navigation.modalPresentationStyle = .fullScreen
        mapViewController.present(navigation, animated: false)    }

    func showLogout() {

    }

    func showMap() {
        DispatchQueue.main.async {
            self.mapViewController.dismiss(animated: true)
            self.tabBarController.selectedIndex = 0
        }
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
        mapViewController.present(controller, animated: true)
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
            mapViewController.present(detailsNavigation, animated: true, completion: nil)
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

    func didFetchMessages(messages: [Message]) {
        closeMessagesController?.viewModel?.setupCells(messages: messages)
        let location = Location(from: mapViewController.viewModel.currentLocation.coordinate)
        closeMessagesViewModel?.currentLocation = location
    }

    func doLogoff() {
        authService.clearCredentials()
        loginViewController.modalPresentationStyle = .fullScreen
        tabBarController.present(loginViewController, animated: true)
    }

    // MARK: Helpers

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

    private func configureTabBar() {
        let location = Location(from: mapViewController.viewModel.currentLocation.coordinate)
        closeMessagesViewModel = CloseMessagesViewModel(messages: [], currentLocation: location)
        closeMessagesController = CloseMessagesViewController(coordinator: self, viewModel: closeMessagesViewModel!)

        let mapItem = UITabBarItem(title: "Map",
                                   image: UIImage(systemName: IconNamed.map.rawValue),
                                   selectedImage: UIImage(systemName: IconNamed.mapFill.rawValue))
        let closeItem = UITabBarItem(title: AkeeStrings.navTitleCloseMessages,
                                     image: UIImage(systemName: IconNamed.envelope.rawValue),
                                     selectedImage: UIImage(systemName: IconNamed.envelopeFill.rawValue))
        let profileItem = UITabBarItem(title: "Profile",
                                     image: UIImage(systemName: IconNamed.person.rawValue),
                                     selectedImage: UIImage(systemName: IconNamed.personFill.rawValue))

        closeMessagesController!.tabBarItem = closeItem
        mapViewController.tabBarItem = mapItem
        profileViewController.tabBarItem = profileItem
        tabBarController.viewControllers = [mapViewController,
                                            UINavigationController(rootViewController: closeMessagesController!),
                                            profileViewController]
        tabBarController.selectedIndex = 0
        tabBarController.customizeTabBarLayout()
    }
}
