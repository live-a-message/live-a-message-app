//
//  LoginViewController.swift
//  Akee
//
//  Created by Vinicius Mesquita on 22/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import Networking
import DesignSystem
import OSLog

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
        mainView.joinNowButton.addTarget(self, action: #selector(didTapJoinNowButton), for: .touchUpInside)

        mainView.readTheTermsLabel.delegate = self
    }

    @objc func didTapJoinNowButton() {
        coordinator?.showMap()
    }

    @objc func didTapAuthButton() {
        AKLoadingView.shared.startLoading(on: self)
        viewModel?.authenticate()
    }

    @objc func didTapTermsButton() {
        coordinator?.showTermsOfService(.present)
    }
}

extension LoginViewController: SignInWithAppleAuthorizationDelegate {

    func didFinishWithError(_ error: Error) {
        os_log("Error: Failed to signIn")
    }

    func didFinishFetching() {
        UserData.shared.set(value: true, key: .isLoggedIn)
        coordinator?.showMap()
    }
}

extension LoginViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if URL.absoluteString == TermsValue.termsAndConditionsURL.rawValue {
            coordinator?.showTermsOfService(.present)
        }
        return false
    }
}
