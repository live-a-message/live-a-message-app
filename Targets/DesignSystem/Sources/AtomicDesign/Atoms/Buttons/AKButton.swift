//
//  AKButton.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 20/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import TinyConstraints

public class AKButton: UIButton {

    public init(style: AKButtonParamater, icon: ButtonIcon? = nil) {
        super.init(frame: .zero)
        setup(with: style, icon: icon)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(with style: AKButtonParamater = AKButtonStyle.default, icon: ButtonIcon?) {
        if let height = style.height { self.height(height) }
        if let width = style.width { self.width(width) }
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
