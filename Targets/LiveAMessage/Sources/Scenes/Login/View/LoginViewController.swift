//
//  LoginViewController.swift
//  Akee
//
//  Created by Vinicius Mesquita on 22/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import Networking

class LoginViewController: UIViewController {

    let mainView = LoginView()
    var viewModel: LoginViewModelProtocol?
    weak var coordinator: Coordinator?

    init(viewModel: LoginViewModelProtocol, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
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
        mainView.authButton.addTarget(self, action: #selector(didTapAuthButton), for: .touchUpInside)
    }

    @objc func didTapAuthButton() {
        viewModel?.authenticate()
    }
}

extension LoginViewController: SignInWithAppleAuthorizationDelegate {

    func didFinishWithError(_ error: Error) {
        print(error.localizedDescription)
    }

    func didFinishFetching() {
        coordinator?.showMap()
    }
}
