//
//  MessageDetailTableViewCell.swift
//  Akee
//
//  Created by Albert on 29/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class MessageDetailTableViewCell: UITableViewCell, ViewCode {

    lazy var titleLabel: AKLabel = {
        let label = AKLabel(style: AKLabelStyle.title2)
        label.textAlignment = .left
        return label
    }()

    lazy var messageLabel: AKLabel = {
        let label = AKLabel(style: AKLabelStyle.body1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    lazy var messageImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    func fill(with content: String, and image: Data?) {
        configureViews()
        messageLabel.text = content
        guard let data = image else {
            return
        }
        self.messageImage.image = UIImage(data: data)
    }

    func buildHierarchy() {
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(messageImage)
    }

    func setupConstraints() {
        let corner = AKSpacing.medium.value
        let top = AKSpacing.xLarge.value
        titleLabel.top(to: self, offset: corner)
        titleLabel.left(to: self, offset: corner)
        titleLabel.right(to: self, offset: -corner)
        messageLabel.top(to: titleLabel, offset: top)
        messageLabel.left(to: self, offset: corner)
        messageLabel.right(to: self, offset: -corner)
        messageImage.topToBottom(of: messageLabel, offset: AKSpacing.small.value)
        messageImage.left(to: self, offset: corner)
        messageImage.right(to: self, offset: -corner)
        messageImage.height(400)
    }

    func configureViews() {
        buildHierarchy()
        setupConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.messageLabel.sizeToFit()
    }

}
