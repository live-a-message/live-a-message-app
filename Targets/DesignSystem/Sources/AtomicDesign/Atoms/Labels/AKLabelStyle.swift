//
//  AKLabelBuilder.swift
//  Akee
//
//  Created by Vinicius Mesquita on 23/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

extension AKLabelStyle {
    static public let body1 = AKLabelStyle(
        font: UIFont.preferredFont(forTextStyle: .body),
        textSize: .body,
        fontColor: AKColor.mainFontColor
    )
    static public let title1 = AKLabelStyle(
        font: UIFont.preferredFont(forTextStyle: .title1),
        textSize: .title1,
        fontColor: AKColor.mainFontColor
    )
    static public let title2 = AKLabelStyle(
        font: UIFont.preferredFont(forTextStyle: .title2),
        textSize: .title2,
        fontColor: AKColor.mainFontColor
    )
    static public let title3 = AKLabelStyle(
        font: UIFont.preferredFont(forTextStyle: .title3),
        textSize: .title3,
        fontColor: AKColor.mainFontColor
    )
}

public struct AKLabelStyle {
    var font: UIFont?
    var textSize: AKFontSize
    var numberOfLines: Int = 0
    var textAlignment: NSTextAlignment = .center
    var fontColor: UIColor
}
