//
//  ProfileView.swift
//  DesignSystem
//
//  Created by Tales Conrado on 20/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem
import TinyConstraints

class ProfileView: UIView, ViewCode {
    private let logOffButton: AKButton = {
        let button = AKButton(style: AKButtonStyle.default)
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(didTapLogoff), for: .touchUpInside)
        return button
    }()

    var logoffClosure: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildHierarchy() {
        addSubview(logOffButton)
    }

    func setupConstraints() {
        logOffButton.centerXToSuperview()
        logOffButton.bottomToSuperview(offset: -AKSpacing.medium.value, usingSafeArea: true)
        logOffButton.leftToSuperview(offset: AKSpacing.medium.value)
        logOffButton.rightToSuperview(offset: -AKSpacing.medium.value)
    }

    func configureViews() {
        backgroundColor = AKColor.mainBackgroundColor
    }

    @objc
    private func didTapLogoff() {
        logoffClosure?()
        print("Saiu")
    }
}
