//
//  AKButtonStyle.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 20/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

extension AKButtonStyle {
    public static let `default` = AKButtonStyle(
        height: 64.0,
        highlightedColor: AKColor.darkRed,
        backgroundColor: AKColor.mainRed,
        borderWidth: 0.0,
        cornerRadius: 6.0,
        font: UIFont.boldSystemFont(ofSize: 24),
        clipToBounds: true,
        textAlignment: .center
    )

    public static let icon32 = AKButtonStyle(
        height: 32.0,
        width: 40.0,
        clipToBounds: true
    )
}

public struct AKButtonStyle {
    var height: CGFloat?
    var width: CGFloat?
    var highlightedColor: UIColor = .clear
    var backgroundColor: UIColor = .clear
    var borderColor: CGColor = UIColor.clear.cgColor
    var borderWidth: CGFloat = .zero
    var cornerRadius: CGFloat = .zero
    var alpha: CGFloat = 1.0
    var font: UIFont?
    let clipToBounds: Bool
    var contentMode: UIView.ContentMode = .scaleAspectFit
    var contentVerticalAlignment: UIControl.ContentVerticalAlignment = .fill
    var contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .fill
    var textAlignment: NSTextAlignment = .natural
}

public struct ButtonIcon {
    var normal: IconNamed?
    var highlighted: IconNamed?
    var tintColor: UIColor

    public init(normal: IconNamed? = nil, highlighted: IconNamed? = nil, tintColor: UIColor = AKColor.mainRed) {
        self.normal = normal
        self.highlighted = highlighted
        self.tintColor = tintColor
    }
}

public enum IconNamed: String {
    case envelope = "envelope.badge"
    case envelopeFill = "envelope.badge.fill"
    case add = "plus.rectangle.fill"
    case close = "xmark"
    case map = "map"
    case mapFill = "map.fill"
    case person = "person"
    case personFill = "person.fill"
}
