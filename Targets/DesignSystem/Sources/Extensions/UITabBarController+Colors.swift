//
//  UITabBarController+Colors.swift
//  DesignSystem
//
//  Created by Tales Conrado on 20/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

extension UITabBarController {
    public func customizeTabBarLayout() {
        if #available(iOS 15, *) {
            #if swift(>=5.5)
            configureNewTabBarLayout()
            #else
            configureLegacyTabBarLayout()
            #endif
        } else {
            configureLegacyTabBarLayout()
        }
    }

    private func configureLegacyTabBarLayout() {
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: AKColor.mainRed], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: AKColor.gray], for: .normal)
        tabBar.barTintColor = AKColor.mainBackgroundColor
        tabBar.tintColor = AKColor.mainRed
    }

    private func configureNewTabBarLayout() {
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = AKColor.mainBackgroundColor
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: AKColor.mainRed]
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: AKColor.gray]
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
            tabBar.tintColor = AKColor.mainRed
        }
    }
}
