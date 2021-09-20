//
//  AKButton.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 20/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import TinyConstraints

class AKButton: UIButton {

    init(style: AKButtonParamater) {
        super.init(frame: .zero)
        setup(with: style)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(with style: AKButtonParamater = AKButtonStyle.default) {
        self.height(style.height)
        self.backgroundColor    = style.backgroundColor
        self.titleLabel?.font   = style.font
        self.alpha              = style.alpha
        self.clipsToBounds      = style.clipToBounds
        self.layer.borderWidth  = style.borderWidth
        self.layer.borderColor  = style.borderColor
        self.layer.cornerRadius = style.cornerRadius

        self.setBackgroundColor(style.backgroundColor, for: .normal)
        self.setBackgroundColor(style.highlightedColor, for: .highlighted)
    }
}
