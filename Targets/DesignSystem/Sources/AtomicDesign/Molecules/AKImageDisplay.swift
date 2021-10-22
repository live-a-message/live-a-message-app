//
//  AKImageCollection.swift
//  DesignSystem
//
//  Created by Fernando de Lucas da Silva Gomes on 21/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import UIKit

public class AKImageDisplay: UIView, ViewCode {

   public var image: UIImage? = nil {
        didSet {
            self.imageView.image = self.image
            self.deleteButton.isHidden = self.image == nil
        }
    }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var deleteButton: AKButton = {
        let button = AKButton(style: .icon32, icon: ButtonIcon(normal: .close,
                                                               highlighted: .close,
                                                               tintColor: AKColor.white))
        button.backgroundColor = AKColor.mainRed
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()

    public init(with size: CGFloat) {
        super.init(frame: .zero)
        self.buildHierarchy()
        self.setupConstraints()
        self.deleteButton.addTarget(self, action: #selector(removeImage), for: .touchUpInside)
        self.deleteButton.width(size*0.33)
        self.deleteButton.height(size*0.33)
        self.deleteButton.imageEdgeInsets = UIEdgeInsets(top: size*0.05, left: size*0.05, bottom: size*0.05, right: size*0.05)
        self.deleteButton.layer.cornerRadius = size*0.16
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func buildHierarchy() {
        addSubview(imageView)
        addSubview(deleteButton)
    }

    public func setupConstraints() {
        self.imageView.edgesToSuperview()
        self.deleteButton.top(to: self, offset: -5)
        self.deleteButton.trailing(to: self, offset: 5)
    }

    public func configureViews() {}

    @objc func removeImage() {
        self.image = nil
    }
}
