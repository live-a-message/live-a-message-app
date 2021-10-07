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
        let button = UIButton()
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

    }

    func configureViews() {
        buildHierarchy()
        setupConstraints()
    }
}
