//
//  AKLabel.swift
//  Akee
//
//  Created by Vinicius Mesquita on 23/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public class AKLabel: UILabel {

    public init(style: AKLabelParamater) {
        super.init(frame: .zero)
        setup(style: style)
        setupAcessibility()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupAcessibility() {
        self.adjustsFontForContentSizeCategory = true
        self.isAccessibilityElement = true
    }

    func setup(style: AKLabelParamater = AKLabelStyle.body1) {
        self.font          = style.font?.withSize(style.textSize.value)
        self.textColor     = style.fontColor
        self.numberOfLines = style.numberOfLines
        self.textAlignment = style.textAlignment
    }
}
