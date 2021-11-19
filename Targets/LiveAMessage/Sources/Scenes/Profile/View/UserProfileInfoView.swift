//
//  UserProfileInfoView.swift
//  Akee
//
//  Created by Tales Conrado on 26/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem
import TinyConstraints
import Networking

class UserProfileInfoView: UIView {
    private let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = AkeeAsset.avatar.image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = AKSpacing.xxxLarge.value / 2
        imageView.clipsToBounds = true

        return imageView
    }()

    private let nameLabel: AKLabel = {
        let label = AKLabel(style: .title2)
        label.numberOfLines = 2
        label.text = UserData.shared.name
        label.textAlignment = .left
        return label
    }()

    private let usernameLabel: AKLabel = {
        let label = AKLabel(style: .body2)
        label.numberOfLines = 2
        label.text = UserData.shared.username
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserProfileInfoView: ViewCode {
    func buildHierarchy() {
        addSubview(profilePictureImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
    }

    func setupConstraints() {
        setupProfilePictureConstraints()
        setupFullNameLabelConstraints()
        setupUsernameLabelConstraints()
    }

    func configureViews() {
        buildHierarchy()
        setupConstraints()
    }

    private func setupProfilePictureConstraints() {
        profilePictureImageView.topToSuperview(offset: AKSpacing.small.value)
        profilePictureImageView.leftToSuperview(offset: AKSpacing.small.value)
        profilePictureImageView.height(AKSpacing.xxxLarge.value)
        profilePictureImageView.widthToHeight(of: profilePictureImageView)
        profilePictureImageView.bottomToSuperview(offset: -AKSpacing.small.value)
    }

    private func setupFullNameLabelConstraints() {
        nameLabel.bottom(to: profilePictureImageView, profilePictureImageView.centerYAnchor)
        nameLabel.leadingToTrailing(of: profilePictureImageView, offset: AKSpacing.xSmall.value)
        nameLabel.trailingToSuperview(offset: -AKSpacing.small.value)
    }

    private func setupUsernameLabelConstraints() {
        usernameLabel.topToBottom(of: nameLabel, offset: AKSpacing.xxxSmall.value)
        usernameLabel.leadingToTrailing(of: profilePictureImageView, offset: AKSpacing.xSmall.value)
        usernameLabel.trailingToSuperview(offset: -AKSpacing.small.value)
    }
}
