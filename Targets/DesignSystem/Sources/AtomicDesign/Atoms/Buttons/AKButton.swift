//
//  AKButton.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 20/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

public class AKButton: UIButton {

    private var height: CGFloat?
    private var width: CGFloat?

    public init(style: AKButtonStyle, icon: ButtonIcon? = nil) {
        super.init(frame: .zero)
        setup(with: style, icon: icon)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
         if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
         }
         if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
         }
    }

    func setup(with style: AKButtonStyle = AKButtonStyle.default, icon: ButtonIcon?) {
        self.height             = style.height
        self.width              = style.width
        self.backgroundColor    = style.backgroundColor
        self.titleLabel?.font   = style.font
        self.alpha              = style.alpha
        self.clipsToBounds      = style.clipToBounds
        self.layer.borderWidth  = style.borderWidth
        self.layer.borderColor  = style.borderColor
        self.layer.cornerRadius = style.cornerRadius
        self.contentHorizontalAlignment = style.contentHorizontalAlignment
        self.contentVerticalAlignment   = style.contentVerticalAlignment
        self.imageView?.tintColor       = icon?.tintColor

        self.setBackgroundColor(style.backgroundColor, for: .normal)
        self.setBackgroundColor(style.highlightedColor, for: .highlighted)
        if let icon = icon { self.setIcon(imageIcon: icon) }
    }
}
