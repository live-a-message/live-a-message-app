//
//  AKFontSize.swift
//  DesignSystem
//
//  Created by Vinicius Mesquita on 23/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

/// Structs where you can add reusable spacing pattern
/// Example: ```AKFontSize.body.value // will add your font size```
public struct AKFontSize: Equatable {

    public let value: CGFloat

    /// value: 17.00
    public static let body = AKFontSize(value: Value.body.rawValue)
    /// value: 28.00
    public static let title1 = AKFontSize(value: Value.title1.rawValue)
    /// value: 22.00
    public static let title2 = AKFontSize(value: Value.title2.rawValue)
    /// value: 20.00
    public static let title3 = AKFontSize(value: Value.title3.rawValue)

    private enum Value: CGFloat, CaseIterable {
        case body     = 17.00
        case title1   = 28.00
        case title2   = 22.00
        case title3   = 20.00
    }

    public static func == (lhs: AKFontSize, rhs: AKFontSize) -> Bool {
        return lhs.value == rhs.value
    }
}
