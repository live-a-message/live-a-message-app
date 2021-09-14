//
//  AdMessageView.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem
import TinyConstraints

class AdMessageView: UIView {
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        return textField
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
        addSubview(textField)
    }
    
    func setupConstraints() {
        cancelButton.top(to: self, offset: 24)
        cancelButton.left(to: self, offset: 24)
        saveButton.top(to: self, offset: 24)
        saveButton.right(to: self, offset: -24)
        textField.edgesToSuperview(excluding: .top)
        textField.topToBottom(of: cancelButton, offset: 16)
    }
    
    func configureViews() {
        
    }
    
}
