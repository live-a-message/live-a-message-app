//
//  TermsViewController.swift
//  Akee
//
//  Created by Vinicius Mesquita on 30/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {

    private let mainView = TermsView()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }

    @objc func didTapConfirmButton() {
        dismiss(animated: true)
    }
}
