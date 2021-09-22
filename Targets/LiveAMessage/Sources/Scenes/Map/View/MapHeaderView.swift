//
//  MapHeaderView.swift
//  LiveAMessage
//
//  Created by Albert on 15/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem

class MapHeaderView: UIView, ViewCode {

    var rightButtonAction: (() -> Void)?
    var leftButtonAction: (() -> Void)?

    lazy var rightButton: AKButton = {
        let button = AKButton(style: AKButtonStyle.icon32, icon: ButtonIcon(normal: .add))
        button.addTarget(self, action: #selector(rightButtonTouched), for: .touchUpInside)
        return button
    }()

    lazy var leftButton: AKButton = {
        let button = AKButton(style: AKButtonStyle.icon32, icon: ButtonIcon(normal: .envelope))
        button.addTarget(self, action: #selector(leftButtonTouched), for: .touchUpInside)
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
        rightButton.topToSuperview(offset: AKSpacing.small.value)
        rightButton.bottomToSuperview(offset: -AKSpacing.small.value)
        rightButton.rightToSuperview(offset: -AKSpacing.small.value)

        leftButton.topToSuperview(offset: AKSpacing.small.value)
        leftButton.bottomToSuperview(offset: -AKSpacing.small.value)
        leftButton.leftToSuperview(offset: AKSpacing.small.value)

        edgesToSuperview(excluding: .bottom, usingSafeArea: true)
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
