//
//  TermsViewController.swift
//  Akee
//
//  Created by Vinicius Mesquita on 30/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import Networking
import DesignSystem

class TermsViewController: UIViewController {

    private let mainView = TermsView()
    private let service: UserService = CloudKitUserService()
    private var firstLoad: Bool = true

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.service.fetchTerms { result in
            switch result {
            case .success(let terms):
                self.mainView.bind(terms: terms)
            case .failure(_):
                AKLoadingView.shared.startLoading(on: self)
                AKLoadingView.shared.stopLoading(didSucceed: false)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dismiss(animated: true)
                }
            }
        }

        mainView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }

    @objc func didTapConfirmButton() {
        UserData.shared.set(value: true, key: .agreeWithTerms)
        dismiss(animated: true)
    }
}
