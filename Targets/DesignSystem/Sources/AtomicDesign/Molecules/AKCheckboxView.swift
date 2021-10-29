//
//  AKCheckboxView.swift
//  DesignSystem
//
//  Created by Vinicius Mesquita on 21/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public class AKCheckboxView: UIView {

    public lazy var checkboxButton: AKButton = {
        AKButton(style: AKButtonStyle.checkbox)
    }()

    public lazy var titleButton: AKButton = {
        AKButton(style: AKButtonStyle.text)
    }()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension AKCheckboxView: ViewCode {
    public func buildHierarchy() {
        addSubview(checkboxButton)
        addSubview(titleButton)
    }

    public func setupConstraints() {
        let offsetButton = AKSpacing.xxLarge.value
        let titleLabelInsets = UIEdgeInsets(
            top: .zero,
            left: AKSpacing.large.value + offsetButton,
            bottom: .zero,
            right: AKSpacing.medium.value
        )
        checkboxButton.leading(to: self, offset: offsetButton)
        checkboxButton.centerY(to: titleButton)

        titleButton.edges(to: self, insets: titleLabelInsets)
    }

    public func configureViews() {
        titleButton.titleLabel?.textAlignment = .left
        titleButton.titleLabel?.numberOfLines = 0
        titleButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }

}
