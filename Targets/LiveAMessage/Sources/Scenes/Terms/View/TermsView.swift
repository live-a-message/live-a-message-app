//
//  TermsView.swift
//  Akee
//
//  Created by Vinicius Mesquita on 30/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem
import TinyConstraints
import AuthenticationServices

class TermsView: UIView, ViewCode {

    lazy var titleLabel: AKLabel = {
        AKLabel(style: AKLabelStyle.title2)
    }()

    lazy var descriptionLabel: AKLabel = {
        let label = AKLabel(style: AKLabelStyle.body1)
        label.textAlignment = .justified
        return label
    }()

    lazy var confirmButton: AKButton = {
        let button = AKButton(style: AKButtonStyle.default)
        button.setTitle("Agree", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = AKColor.shadowRed
        button.isEnabled = false
        button.height(48)
        return button
    }()

    lazy var container: AKScrollViewContainer = {
        let container = AKScrollViewContainer()
        container.stackView.axis = .vertical
        container.spacing = AKSpacing.medium.value
        container.stackView.isLayoutMarginsRelativeArrangement = true
        container.scrollView.delegate = self
        container.stackView.layoutMargins = UIEdgeInsets(
            top: AKSpacing.xxxLarge.value,
            left: AKSpacing.medium.value,
            bottom: AKSpacing.xxxLarge.value * 2,
            right: AKSpacing.medium.value
        )
        return container
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
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
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(descriptionLabel)
        container.addSubview(confirmButton)
    }

    func setupConstraints() {
        container.edgesToSuperview(usingSafeArea: true)

        confirmButton.leadingToSuperview(offset: AKSpacing.medium.value)
        confirmButton.trailingToSuperview(offset: AKSpacing.medium.value)
        confirmButton.bottomToSuperview(offset: -AKSpacing.xLarge.value)
    }

    func configureViews() {
        titleLabel.text = "Terms and Conditions (\"Terms\")"
        descriptionLabel.text = """

            Last updated: 30/09/2021

            Please read these Terms and Conditions ("Terms", "Terms and Conditions")
            carefully before using the Akee mobile application (the "Service")
            operated by Akee ("us", "we", or "our").

            Your access to and use of the Service is conditioned on your acceptance
            of and compliance with these Terms. These Terms apply to all visitors,
            users and others who access or use the Service.

            By accessing or using the Service you agree to be bound by these Terms.
            If you disagree with any part of the terms then you may not access the Service.

            Content

            Our Service allows you to post, link, store, share and otherwise make
            available certain information, text, graphics, or other material
            ("Content"). You are responsible for the content, and in any ways
            should you post content that offends or abuses other users or any people.
            You'’l be subject to being blocked from using our app and losing your account.

            Links To Other Web Sites

            Our Service may contain links to third-party web sites or services
            that are not owned or controlled by Akee.

            Akee has no control over, and assumes no responsibility for, the content,
            privacy policies, or practices of any third party web sites or services.
            You further acknowledge and agree that Akee shall not be responsible or liable,
            directly or indirectly, for any damage or loss caused or alleged to be caused
            by or in connection with use of or reliance on any such content, goods or
            services available on or through any such web sites or services.

            Changes

            We reserve the right, at our sole discretion, to modify or replace these
            Terms at any time. If a revision is material we will try to provide at
            least 30 days' notice prior to any new terms taking effect. What constitutes
            a material change will be determined at our sole discretion.

            Contact Us

            If you have any questions about these Terms, please contact us.
            """
    }

}

extension TermsView: UIScrollViewDelegate {

   func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let reachesBottom = scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        if reachesBottom {
            confirmButton.isEnabled = true
            confirmButton.backgroundColor = AKColor.mainRed
        } else {
            confirmButton.backgroundColor = AKColor.shadowRed
            confirmButton.isEnabled = false
        }
    }

}
