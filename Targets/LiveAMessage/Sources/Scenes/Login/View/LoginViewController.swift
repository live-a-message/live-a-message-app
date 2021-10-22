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

    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
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
        mainView.checkboxView.checkboxButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        mainView.checkboxView.titleButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
    }

    @objc func didTapAuthButton() {
        viewModel?.authenticate()
    }

    @objc func didTapTermsButton() {
        coordinator?.showTermsOfService()
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
