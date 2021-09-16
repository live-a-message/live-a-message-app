//
//  CloseMessagesViewController.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

class CloseMessagesViewController: UIViewController {

    let mainView = CloseMessagesView()
    var viewModel: CloseMessagesViewModelProtocol?

    init(viewModel: CloseMessagesViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
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
        self.title = "Close Messages"
        if let viewModel = viewModel {
            mainView.bind(viewModel: viewModel)
        }
    }
}
