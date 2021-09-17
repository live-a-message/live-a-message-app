//
//  MapHeaderView.swift
//  LiveAMessage
//
//  Created by Albert on 15/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem

enum ButtonInsets: CGFloat {
    case border = 16
    case width = 36
}

class MapHeaderView: UIView, ViewCode {

    var rightButtonAction: (() -> Void)?
    var leftButtonAction: (() -> Void)?

    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(.add, for: .normal)
        button.tintColor = Colors.mainRed
        button.addTarget(self, action: #selector(rightButtonTouched), for: .touchUpInside)
        return button
    }()

    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.tintColor = Colors.mainRed
        button.setTitleColor(Colors.mainRed, for: .normal)
        button.addTarget(self, action: #selector(leftButtonTouched), for: .touchUpInside)
        button.backgroundColor = Colors.mainRed
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func buildHierarchy() {
        addSubview(rightButton)
        addSubview(leftButton)
    }

    func setupConstraints() {
        rightButton.topToSuperview(offset: ButtonInsets.border.rawValue, usingSafeArea: true)
        rightButton.right(to: self, offset: -ButtonInsets.border.rawValue)
        rightButton.width(ButtonInsets.width.rawValue)
        rightButton.aspectRatio(1)
        
        leftButton.topToSuperview(offset: ButtonInsets.border.rawValue, usingSafeArea: true)
        leftButton.left(to: self, offset: ButtonInsets.border.rawValue)
        leftButton.width(ButtonInsets.width.rawValue)
        leftButton.aspectRatio(1)

        height(64)
        edgesToSuperview(excluding: .bottom)
    }

    func configureViews() {

    }

    @objc func rightButtonTouched() {
        rightButtonAction?()
    }

    @objc func leftButtonTouched() {
        leftButtonAction?()
    }
}
