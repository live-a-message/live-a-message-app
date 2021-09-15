//
//  AddMessageView.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem
import TinyConstraints

class AddMessageView: UIView, ViewCode {
    var cancelAction: (() -> ())?
    var saveAction: (() -> ())?
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.red, for: .normal)
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
        cancelButton.top(to: self, offset: 24)
        cancelButton.left(to: self, offset: 24)
        saveButton.top(to: self, offset: 24)
        saveButton.right(to: self, offset: -24)
        textView.edgesToSuperview(excluding: .top, insets: .horizontal(16))
        textView.topToBottom(of: cancelButton, offset: 16)
    }
    
    func configureViews() {
        textView.becomeFirstResponder()
        textView.isScrollEnabled = true
        textView.tintColor = .red
        textView.font = .systemFont(ofSize: 14)
    }
    
    func setKeyboardView(height: CGFloat) {
        textView.bottom(to: self, offset: -height)
    }
    
    @objc func cancelButtonAction() {
        cancelAction?()
    }
}
