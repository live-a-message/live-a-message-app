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
    var rightBottomButtonAction: (() -> Void)?

    lazy var rightButton: AKButton = {
        let button = AKButton(style: AKButtonStyle.minimumTappable, icon: ButtonIcon(normal: .add))
        button.addTarget(self, action: #selector(rightButtonTouched), for: .touchUpInside)
        return button
    }()

    lazy var rightBottomButton: AKButton = {
        let icon = ButtonIcon(normal: .location, highlighted: .locationSelected)
        let button = AKButton(style: AKButtonStyle.minimumTappable, icon: icon)
        button.addTarget(self, action: #selector(locationButtonTouched), for: .touchUpInside)
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
        addSubview(rightBottomButton)
    }

    func setupConstraints() {
        rightButton.topToSuperview(offset: AKSpacing.small.value)
        rightButton.rightToSuperview(offset: -AKSpacing.small.value)

        rightBottomButton.topToBottom(of: rightButton, offset: AKSpacing.small.value)
        rightBottomButton.rightToSuperview(offset: -AKSpacing.small.value)
        rightBottomButton.bottomToSuperview(offset: -AKSpacing.small.value)

        edgesToSuperview(excluding: .bottom, usingSafeArea: true)
    }

    func configureViews() {

    }

    @objc func rightButtonTouched() {
        rightButtonAction?()
    }

    @objc func locationButtonTouched() {
        rightBottomButtonAction?()
    }
}
