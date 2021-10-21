//
//  AddMessageView.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem

class AddMessageView: UIView, ViewCode {
    var cancelAction: (() -> Void)?
    var saveAction: ((String) -> Void)?
    var cameraAction: (() -> Void)?

    let keyManager = KeyBoardManager()

    private var textBottomAnchor: NSLayoutConstraint?

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(AkeeStrings.btnCancel, for: .normal)
        button.setTitleColor(AKColor.mainRed, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return button
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle(AkeeStrings.btnPost, for: .normal)
        button.setTitleColor(AKColor.mainRed, for: .normal)
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        return button
    }()

    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    lazy var toolBar: AKToolBar = {
        let toolBar = AKToolBar()
        let addButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraButtonAction))
        toolBar.setItems([addButton], animated: false)
        return toolBar
    }()

    lazy var imageView: AKImageDisplay = {
        let imageView = AKImageDisplay(with: 60)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
        setupConstraints()
        configureViews()
        keyboarHandle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func buildHierarchy() {
        addSubview(cancelButton)
        addSubview(saveButton)
        addSubview(textView)
        addSubview(imageView)
    }

    func setupConstraints() {
        cancelButton.top(to: self, offset: AKSpacing.medium.value)
        cancelButton.left(to: self, offset: AKSpacing.medium.value)
        saveButton.top(to: self, offset: AKSpacing.medium.value)
        saveButton.right(to: self, offset: -AKSpacing.medium.value)
        textView.edgesToSuperview(excluding: .top, insets: .horizontal(AKSpacing.small.value))
        textView.topToBottom(of: cancelButton, offset: AKSpacing.small.value)
        imageView.leading(to: textView)
        imageView.bottom(to: textView)
        imageView.width(60)
        imageView.height(60)

        textBottomAnchor = textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        textBottomAnchor?.isActive = true
    }

    func configureViews() {
        textView.becomeFirstResponder()
        backgroundColor = AKColor.mainBackgroundColor
        textView.backgroundColor = AKColor.mainBackgroundColor
        textView.isScrollEnabled = true
        textView.tintColor = .red
        textView.font = .systemFont(ofSize: 14)
        textView.inputAccessoryView = toolBar
    }

    @objc func saveButtonAction() {
        saveAction?(textView.text)
    }

    @objc func cancelButtonAction() {
        cancelAction?()
    }

    @objc func cameraButtonAction() {
        cameraAction?()
    }

    public func keyboarHandle() {
       keyManager.keyboardWillChangeFrame = { [unowned self] isHiding, newHeight, animationDuration, animationCurve in

           self.layoutIfNeeded()
           self.textBottomAnchor?.isActive = false
           if isHiding {
                self.textBottomAnchor?.constant = 0
                self.textBottomAnchor?.isActive = true
           } else {
                self.textBottomAnchor?.constant = -newHeight
                self.textBottomAnchor?.isActive = true
           }
           UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurve, animations: { [weak self] in
                self?.layoutIfNeeded()
           })
       }
    }

}

extension AddMessageView {
    public var imageData: Data? {
        return self.imageView.image?.pngData()
    }

    func setImage(_ image: UIImage?) {
        self.imageView.image = image
    }
}
