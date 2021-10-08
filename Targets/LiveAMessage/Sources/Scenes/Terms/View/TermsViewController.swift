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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchTerms()
    }
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }

    func fetchTerms() {
        self.mainView.loadingIndicator.set(.load)
        self.service.fetchTerms { result in
            switch result {
            case .success(let terms):
                self.mainView.loadingIndicator.set(.stop)
                self.mainView.bind(terms: terms)
            case .failure(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.mainView.loadingIndicator.set(.stop)
                    self.dismiss(animated: true)
                }
            }
        }
    }

    @objc func didTapConfirmButton() {
        UserData.shared.set(value: true, key: .agreeWithTerms)
        dismiss(animated: true)
    }
}
