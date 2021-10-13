//
//  CloseMessagesViewController.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import Networking

class CloseMessagesViewController: UIViewController {

    let mainView = CloseMessagesView()
    var viewModel: CloseMessagesViewModelProtocol?
    var coordinator: Coordinator?

    init(coordinator: Coordinator, viewModel: CloseMessagesViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.coordinator = coordinator
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AkeeStrings.navTitleCloseMessages

        mainView.tableView.bind(sections: viewModel?.sections ?? [])

        mainView.tableView.didSelectRowAt = { [weak self] item in
            self?.coordinator?.showMessageDetails(with: item.message, fromPin: false)
        }

        setupNavigationController()
        setupCloseAction()
        setupRefreshControl()
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
        self.navigationItem.leftBarButtonItem = mainView.closeButton
    }

    @objc private func dismissView() {
        dismiss(animated: true)
    }

    @objc private func refresh() {
        guard let location = viewModel?.currentLocation else { return }
        viewModel?.service
            .fetchMessages(location: location, radius: 300, completion: { result in
                switch result {
                case .success(let messages):
                    self.viewModel?.setupCells(messages: messages)
                    self.mainView.tableView.sections = self.viewModel?.sections ?? []
                    self.mainView.reloadData()
                case .failure(_):
                    print("errorHandlerNotImplemented:")
                }
        })
    }
}
