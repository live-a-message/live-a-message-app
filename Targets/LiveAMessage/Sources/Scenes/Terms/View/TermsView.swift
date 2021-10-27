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
import Networking

class TermsView: UIView, ViewCode {

    lazy var titleLabel: AKLabel = {
        AKLabel(style: AKLabelStyle.title2)
    }()

    lazy var loadingIndicator = AKLoadingIndicator(frame: .zero)

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
        button.isHidden = UserData.shared.agreeWithTerms
        button.isEnabled = false
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
        container.addSubview(loadingIndicator)
    }

    func setupConstraints() {
        container.edgesToSuperview(usingSafeArea: true)
        loadingIndicator.center(in: self)

        confirmButton.leadingToSuperview(offset: AKSpacing.medium.value)
        confirmButton.trailingToSuperview(offset: AKSpacing.medium.value)
        confirmButton.bottomToSuperview(offset: -AKSpacing.xLarge.value)
    }

    func bind(terms: Terms) {
        DispatchQueue.main.async {
            self.titleLabel.text = terms.title
            self.descriptionLabel.text = terms.content
        }
    }

    func configureViews() { }

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
