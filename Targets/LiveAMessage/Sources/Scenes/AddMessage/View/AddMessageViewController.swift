//
//  AddMessageViewController.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

class AddMessageViewController: UIViewController {
    
    private weak var viewModel: AddMessageViewModelProtocol?
    private lazy var messageView = AddMessageView()
    
    override func loadView() {
        messageView.cancelAction = cancel
        view = messageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardObserver()
    }
    
    private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    private func save(_ message: String) {
        viewModel?.saveMessage()
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
