//
//  UserProfileInfoView.swift
//  Akee
//
//  Created by Tales Conrado on 26/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class UserProfileInfoView: UIView {
    private let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AkeeAsset.avatar.image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12

        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()

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
    }

    func setupConstraints() {
        
    }

    func configureViews() {
        buildHierarchy()
        setupConstraints()
    }
}
