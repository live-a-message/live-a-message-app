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

    let userNameLabel: UITextField = {
        let textfield = UITextField()
        textfield.font = .systemFont(ofSize: 22)
        textfield.text = Configuration.shared.name
        textfield.textAlignment = .left
        textfield.isUserInteractionEnabled = false
        return textfield
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
        addSubview(userNameLabel)
    }

    func setupConstraints() {
        setupProfilePictureConstraints()
        setupUserNameLabelConstraints()
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

    private func setupUserNameLabelConstraints() {
        userNameLabel.bottom(to: profilePictureImageView, profilePictureImageView.centerYAnchor)
        userNameLabel.leadingToTrailing(of: profilePictureImageView, offset: AKSpacing.small.value)
        userNameLabel.trailingToSuperview(offset: -AKSpacing.small.value)
    }
}

extension UserProfileInfoView {
    func endEdit() {
        UserData.shared.name = self.userNameLabel.text
    }
}
