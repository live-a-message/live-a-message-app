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
        let toolBar = AKToolBar()
        let buttonnn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveButtonAction))
        toolBar.setItems([buttonnn], animated: false)
//        toolBar.barStyle = .default
//        toolBar.sizeToFit()

//        let toolbar = AKToolBar()
//        let buttoonn = AKButton(style: .default, icon: ButtonIcon(normal: .add))
//        buttoonn.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
//        buttoonn.translatesAutoresizingMaskIntoConstraints = false
//        toolbar.set(for: [buttoonn])

        textView.inputAccessoryView = toolBar
//        buttoonn.edgesToSuperview()
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
}
