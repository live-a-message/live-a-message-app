//
//  LoginView.swift
//  Akee
//
//  Created by Vinicius Mesquita on 22/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem
import TinyConstraints
import AuthenticationServices

class LoginView: UIView, ViewCode {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map_dark")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    lazy var authButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.height(48)
        return button
    }()

    lazy var container: AKScrollViewContainer = {
        let container = AKScrollViewContainer()
        container.stackView.axis = .vertical
        container.spacing = AKSpacing.medium.value
        container.stackView.isLayoutMarginsRelativeArrangement = true
        container.stackView.layoutMargins = UIEdgeInsets(
            top: AKSpacing.xxxLarge.value,
            left: AKSpacing.medium.value,
            bottom: AKSpacing.xxxLarge.value,
            right: AKSpacing.medium.value
        )
        return container
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func buildHierarchy() {
        addSubview(container)
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(descriptionLabel)
        container.addSubview(authButton)
    }

    func setupConstraints() {
        container.edgesToSuperview(usingSafeArea: true)

        authButton.leadingToSuperview(offset: AKSpacing.xLarge.value)
        authButton.trailingToSuperview(offset: AKSpacing.xLarge.value)
        authButton.bottomToSuperview(offset: -AKSpacing.xxxLarge.value)
    }

    func configureViews() {
        titleLabel.text = "Sign In"
        descriptionLabel.text = """
            Lorem ipsum dolor sit amet, consectetur
            adipiscing elit.Etiam eget ligula eu lectus
            lobortis condimentum. Aliquam nonummy auctor massa.
            """
    }

}
