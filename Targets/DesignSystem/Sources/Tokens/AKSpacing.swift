//
//  LSSpacing.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 20/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

/// Structs where you can add reusable spacing pattern
/// Example: LMSpacing.xxxSmall.value will add your spacing
public struct AKSpacing: Equatable {

    public let value: CGFloat

    public static let xxxSmall = AKSpacing(value: Value.xxxSmall.rawValue)
    public static let xxSmall  = AKSpacing(value: Value.xxSmall.rawValue)
    public static let xSmall   = AKSpacing(value: Value.xSmall.rawValue)
    public static let small    = AKSpacing(value: Value.large.rawValue)
    public static let medium   = AKSpacing(value: Value.medium.rawValue)
    public static let large    = AKSpacing(value: Value.large.rawValue)
    public static let xLarge   = AKSpacing(value: Value.xLarge.rawValue)
    public static let xxLarge  = AKSpacing(value: Value.xxLarge.rawValue)
    public static let xxxLarge = AKSpacing(value: Value.xxxLarge.rawValue)

    private enum Value: CGFloat, CaseIterable {
        case zero     = 0.00
        case xxxSmall = 4.00
        case xxSmall  = 8.00
        case xSmall   = 12.00
        case small    = 16.00
        case medium   = 24.00
        case large    = 32.00
        case xxxLarge = 64.00
        case xxLarge  = 48.00
        case xLarge   = 40.00
    }

    public static func == (lhs: AKSpacing, rhs: AKSpacing) -> Bool {
        return lhs.value == rhs.value
    }
}
