//
//  AKButtonStyle.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 20/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

public struct AKButtonStyle {
    static let `default` = AKButtonParamater(
        height: 64.0,
        highlightedColor: .white,
        backgroundColor: .systemRed,
        borderColor: UIColor.black.cgColor,
        borderWidth: 6.0,
        cornerRadius: 0.0,
        alpha: 1.0,
        font: UIFont.boldSystemFont(ofSize: 24),
        clipToBounds: true
    )
}

struct AKButtonParamater {
    let height: CGFloat
    let highlightedColor: UIColor
    let backgroundColor: UIColor
    let borderColor: CGColor
    let borderWidth: CGFloat
    var cornerRadius: CGFloat
    let alpha: CGFloat
    var font: UIFont?
    let clipToBounds: Bool
}
