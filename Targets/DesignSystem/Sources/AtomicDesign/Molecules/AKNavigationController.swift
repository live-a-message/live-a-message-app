//
//  CustomNavigationViewController.swift
//  DesignSystem
//
//  Created by Vinicius Mesquita on 06/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public enum AKNavigationStyle {
    case transparent
}

public class AKNavigationController: UINavigationController {

    public init(style: AKNavigationStyle? = nil) {
        super.init(nibName: nil, bundle: nil)
        configure(style: style)
    }

    public init(rootViewController: UIViewController, style: AKNavigationStyle? = nil) {
        super.init(rootViewController: rootViewController)
        configure(style: style)
    }

    func configure(style: AKNavigationStyle?) {
        switch style {
        case .transparent: configureTransparentStyle()
        default:
            break
        }
    }

    func configureTransparentStyle() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
