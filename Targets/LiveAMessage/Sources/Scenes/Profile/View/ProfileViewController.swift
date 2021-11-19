//
//  ProfileViewController.swift
//  DesignSystem
//
//  Created by Tales Conrado on 20/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class ProfileViewController: UIViewController {
    private let contentView = ProfileView()
    private let viewModel: ProfileViewModelProtocol = ProfileViewModel()
    private var editingState: Bool = false {
        didSet {
            updateUI()
        }
    }

    weak var coordinator: Coordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.bind(sections: viewModel.sections)
        contentView.tableView.didSelectRowAt = { self.route(with: $0.type) }
        navigationController?.title = AkeeStrings.navTitleProfile
        navigationController?.navigationBar.topItem?.rightBarButtonItem = buildItem()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showIcons))
        self.contentView.profileView.profilePictureImageView.addGestureRecognizer(gesture)
        
    }

    override func loadView() {
        view = contentView
    }

    private func doLogoff() {
        coordinator?.doLogoff()
    }

    private func route(with type: ProfileItemType) {
        switch type {
        case .termsOfService:
            guard let nav = navigationController else { return }
            self.coordinator?.showTermsOfService(.push(nav: nav))
        case .logout:
            self.coordinator?.doLogoff()
        default:
            break
        }
    }

    @objc
    func allowEdit() {
        self.editingState = true
    }

    @objc
    func disallowEdit() {
        self.editingState = false
        self.contentView.profileView.endEdit()
    }
    
    @objc
    func showIcons() {
        coordinator?.showIcons()
    }

    func updateUI() {
        self.contentView.profileView.userNameLabel.isUserInteractionEnabled = editingState
        if editingState {self.contentView.profileView.userNameLabel.becomeFirstResponder()}
        navigationController?.navigationBar.topItem?.rightBarButtonItem = buildItem()
    }

    func buildItem() -> UIBarButtonItem {
        if editingState {
            let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(disallowEdit))
            button.tintColor = AKColor.red
            return button
        } else {
            let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(allowEdit))
            button.tintColor = AKColor.red
            return button
        }
    }
}
extension ProfileViewController: UIViewControllerTransitioningDelegate {
func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
       return HalfSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
   }
}

class HalfSizePresentationController: UIPresentationController {
   override var frameOfPresentedViewInContainerView: CGRect {
       guard let bounds = containerView?.bounds else { return .zero }
       return CGRect(x: 0, y: bounds.height*0.75, width: bounds.width, height: bounds.height / 4)
   }
}
