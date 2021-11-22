//
//  AddMessageViewController.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem
import Networking
import PhotosUI

class AddMessageViewController: UIViewController {

    var handleDismiss : (() -> Void)?
    let viewModel: AddMessageViewModelProtocol
    private lazy var messageView = AddMessageView()
    lazy var picker = UIImagePickerController()

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
        messageView.cameraAction = requestAuthorizationForPhotos
        view = messageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.view.backgroundColor = AKColor.mainBackgroundColor
    }

    private func cancel() {
        dismiss(animated: true, completion: nil)
    }

    private func save(_ message: String) {
        guard UserData.shared.agreeWithTerms else {
            present(TermsViewController(), animated: true)
            return
        }
        viewModel.saveMessage(
            with: message,
            image: self.messageView.imageData
        )
      dismiss(animated: true) {
        self.handleDismiss?()
        AKAnimationView.animateAboveAll(with: "send_message")
      }
    }

    @objc func tooglePicker() {
        self.picker.allowsEditing = false
        self.picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    @objc private func requestAuthorizationForPhotos() {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status == .authorized {
                    self.tooglePicker()
                }
            }
        } else {
            self.tooglePicker()
        }
    }
}

extension AddMessageViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.messageView.setImage(image)
        }
        dismiss(animated: true, completion: nil)
    }
}
