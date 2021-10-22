//
//  CloseMessagesViewController.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem
import Networking

class CloseMessagesViewController: UIViewController {

    private let mainView = CloseMessagesView()
    let viewModel: CloseMessagesViewModelProtocol
    var coordinator: Coordinator?

    init(coordinator: Coordinator, viewModel: CloseMessagesViewModelProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AkeeStrings.navTitleCloseMessages
        mainView.tableView.sectionsTitle = viewModel.sectionsTitle.map({ $0.title })
        mainView.tableView.bind(sections: viewModel.sections)

        mainView.tableView.didSelectRowAt = { [weak self] item in
            self?.coordinator?.showMessageDetails(with: item.message, fromPin: false)
        }

        setupNavigationController()
        setupCloseAction()
        setupRefreshControl()
        if viewModel.sections.isEmpty {
            refresh()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.reloadData()
    }

    private func setupRefreshControl() {
        mainView.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    private func setupCloseAction() {
        mainView.closeButton.target = self
        mainView.closeButton.action = #selector(dismissView)
    }

    private func setupNavigationController() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setDefaultAppearance(color: AKColor.mainBackgroundColor)
        self.navigationItem.leftBarButtonItem = mainView.closeButton
    }

    @objc private func dismissView() {
        dismiss(animated: true)
    }

    @objc private func refresh() {
        let location = viewModel.currentLocation
        viewModel.service
            .fetchMessages(location: location, radius: 300, completion: { result in
                switch result {
                case .success(let messages):
                    self.viewModel.setupCells(messages: messages)
                    self.mainView.tableView.sections = self.viewModel.sections
                    self.mainView.tableView.sectionsTitle = self.viewModel.sectionsTitle.map({ $0.title })
                    self.mainView.reloadData()
                case .failure(_):
                    NSLog("Error handler not implemented:", "error")
                }
        })
    }
}
