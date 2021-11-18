//
//  AKEmptyState.swift
//  DesignSystem
//
//  Created by Vinicius Mesquita on 18/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public struct EmptyStateViewModel {

    public let icon: UIImage?
    public let title: String?
    public let description: String?
    public var button: ButtonModel?

    public init(icon: UIImage?, title: String?, description: String?, button: EmptyStateViewModel.ButtonModel? = nil) {
        self.icon = icon
        self.title = title
        self.description = description
        self.button = button
    }

    public struct ButtonModel {
        public init(action: @escaping () -> Void, title: String) {
            self.action = action
            self.title = title
        }
        let action: () -> Void
        let title: String
    }
}

public class AKEmptyState: UIView {

    let style: Style
    public var viewModel: EmptyStateViewModel?

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var titleLabel: AKLabel = { AKLabel(style: .title3) }()
    lazy var descriptionLabel: AKLabel = { AKLabel(style: .body1) }()
    lazy var primaryButton: AKButton = { AKButton(style: .default) }()

    public init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AKEmptyState: ViewCode {

    public enum Style {
        case generic
        case viewModel(_ viewModel: EmptyStateViewModel)
        case withImage(_ image: UIImage)
        case withText(_ title: String)
        case withImageAndTitle(_ image: UIImage, _ title: String)
    }

    public func buildHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(primaryButton)
    }

    public func setupConstraints() {
        let spacing = AKSpacing.medium.value
        let imageSize = CGSize(width: 264, height: 264)

        imageView.centerXToSuperview()
        imageView.topToSuperview(offset: AKSpacing.xxxLarge.value * 2)
        imageView.size(imageSize)

        titleLabel.topToBottom(of: imageView, offset: spacing)
        titleLabel.leadingToSuperview(offset: spacing)
        titleLabel.trailingToSuperview(offset: spacing)

        descriptionLabel.topToBottom(of: titleLabel, offset: spacing)
        descriptionLabel.leadingToSuperview(offset: spacing)
        descriptionLabel.trailingToSuperview(offset: spacing)

        primaryButton.topToBottom(of: descriptionLabel, offset: AKSpacing.xxLarge.value)
        primaryButton.leadingToSuperview(offset: spacing)
        primaryButton.trailingToSuperview(offset: spacing)
    }

    public func configureViews() {
        backgroundColor = AKColor.mainBackgroundColor
        primaryButton.isHidden = true
        switch style {
        case .generic:
            imageView.image = DesignSystemAsset.floatingEmptyState.image
            titleLabel.text = DesignSystemStrings.lblGenericEmptyState
        case .withImage(let image):
            imageView.image = image
        case .withText(let title):
            titleLabel.text = title
        case .withImageAndTitle(let image, let title):
            titleLabel.text = title
            imageView.image = image
        case .viewModel(let viewModel):
            configureViewModel(viewModel)
        }
    }

    private func configureViewModel(_ viewModel: EmptyStateViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        imageView.image = viewModel.icon
        if let button = viewModel.button {
            primaryButton.isHidden = false
            primaryButton.setTitle(button.title, for: .normal)
            primaryButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }
    }

    @objc func buttonAction() {
        viewModel?.button?.action()
    }
}
