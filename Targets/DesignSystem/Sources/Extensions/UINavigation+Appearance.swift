//
//  UINavigation+Appearance.swift
//  DesignSystem
//
//  Created by Tales Conrado on 08/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    public func setDefaultAppearance(color: UIColor = .systemBackground) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        standardAppearance = appearance
        scrollEdgeAppearance = standardAppearance
    }
}
