//
//  OnboardingSceneView.swift
//  Akee
//
//  Created by Albert on 07/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import Lottie
import DesignSystem

class OnboardingSceneView: UIView, ViewCode {

    var nextButtonAction: (() -> Void)?

    lazy var animationView: AnimationView = {
        let view = AnimationView()
        view.loopMode = .loop
        view.contentMode = .scaleAspectFit
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = AKLabel(style: AKLabelStyle.title1)
        label.numberOfLines = 0
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = AKLabel(style: AKLabelStyle.body1)
        label.numberOfLines = 0
        return label
    }()

    lazy var nextButton: UIButton = {
        let button = AKButton(style: AKButtonStyle.default)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func buildHierarchy() {
        addSubview(animationView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(nextButton)
    }

    func setupConstraints() {
        animationView.topToSuperview(offset: AKSpacing.xxxLarge.value)
        animationView.height(224)
        animationView.leftToSuperview()
        animationView.rightToSuperview()
        animationView.centerXToSuperview()
        titleLabel.centerXToSuperview()
        titleLabel.topToBottom(of: animationView, offset: AKSpacing.large.value)
        descriptionLabel.topToBottom(of: titleLabel, offset: AKSpacing.xSmall.value)
        descriptionLabel.leftToSuperview(offset: AKSpacing.small.value)
        descriptionLabel.rightToSuperview(offset: -AKSpacing.small.value)
        nextButton.centerXToSuperview()
        nextButton.height(AKSpacing.xxxLarge.value)
        nextButton.leftToSuperview(offset: AKSpacing.xxxLarge.value)
        nextButton.rightToSuperview(offset: -AKSpacing.xxxLarge.value)
        nextButton.bottomToSuperview(offset: -AKSpacing.xxxLarge.value)
    }

    func configureViews() {
        buildHierarchy()
        setupConstraints()
    }

    @objc func didTapNextButton() {
        nextButtonAction?()
    }
}
