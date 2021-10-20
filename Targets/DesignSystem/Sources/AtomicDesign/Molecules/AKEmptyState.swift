//
//  AKEmptyState.swift
//  DesignSystem
//
//  Created by Vinicius Mesquita on 18/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public class AKEmptyState: UIView {

    let style: Style

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var titleLabel: AKLabel = { AKLabel(style: .title3) }()

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
        case withImage(_ image: UIImage)
        case withText(_ title: String)
        case withImageAndTitle(_ image: UIImage, _ title: String)
    }

    public func buildHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
    }

    public func setupConstraints() {
        let spacing = AKSpacing.medium.value
        let imageSize = CGSize(width: 264, height: 264)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -imageSize.height / 3),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    public func configureViews() {
        backgroundColor = AKColor.mainBackgroundColor
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
        }
    }
}
