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
        return textView
    }()

    lazy var toolBar: AKToolBar = {
        let toolBar = AKToolBar()
        let addButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraButtonAction))
        toolBar.setItems([addButton], animated: false)
        return toolBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func buildHierarchy() {
        addSubview(cancelButton)
        addSubview(saveButton)
        addSubview(textView)
    }

    func setupConstraints() {
        cancelButton.top(to: self, offset: AKSpacing.medium.value)
        cancelButton.left(to: self, offset: AKSpacing.medium.value)
        saveButton.top(to: self, offset: AKSpacing.medium.value)
        saveButton.right(to: self, offset: -AKSpacing.medium.value)
        textView.edgesToSuperview(excluding: .top, insets: .horizontal(AKSpacing.small.value))
        textView.topToBottom(of: cancelButton, offset: AKSpacing.small.value)
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

    func setKeyboardView(height: CGFloat) {
        textView.bottom(to: self, offset: -height)
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
}
