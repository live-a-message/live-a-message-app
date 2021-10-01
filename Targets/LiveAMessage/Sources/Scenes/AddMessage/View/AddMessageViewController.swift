//
//  AddMessageViewController.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem

class AddMessageViewController: UIViewController {

    var handleDismiss : (() -> Void)?
    private let viewModel: AddMessageViewModelProtocol
    private lazy var messageView = AddMessageView()

    init(viewModel: AddMessageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        messageView.cancelAction = cancel
        messageView.saveAction = save(_:)
        view = messageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AKColor.mainBackgroundColor
        setKeyboardObserver()
    }

    private func cancel() {
        dismiss(animated: true, completion: nil)
    }

    private func save(_ message: String) {
        viewModel.saveMessage(
            with: message,
            image: ""
        )
      dismiss(animated: true) {
        self.handleDismiss?()
      }
    }

    private func setKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            messageView.setKeyboardView(height: keyboardHeight)
        }
    }

}
