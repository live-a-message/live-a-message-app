//
//  AKLabelBuilder.swift
//  Akee
//
//  Created by Vinicius Mesquita on 23/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public struct AKLabelStyle {
    static public let body1 = AKLabelParamater(
        font: UIFont.preferredFont(forTextStyle: .body),
        textSize: .body,
        fontColor: AKColor.mainFontColor
    )
    static public let title1 = AKLabelParamater(
        font: UIFont.preferredFont(forTextStyle: .title1),
        textSize: .title1,
        fontColor: AKColor.mainFontColor
    )
    static public let title2 = AKLabelParamater(
        font: UIFont.preferredFont(forTextStyle: .title2),
        textSize: .title2,
        fontColor: AKColor.mainFontColor
    )
    static public let title3 = AKLabelParamater(
        font: UIFont.preferredFont(forTextStyle: .title3),
        textSize: .title3,
        fontColor: AKColor.mainFontColor
    )
}

public struct AKLabelParamater {
    var font: UIFont?
    var textSize: AKFontSize
    var numberOfLines: Int = 0
    var textAlignment: NSTextAlignment = .center
    var fontColor: UIColor
}
