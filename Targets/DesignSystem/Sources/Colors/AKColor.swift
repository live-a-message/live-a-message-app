//
//  Colors.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 14/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

public class AKColor: UIColor {

    /// the default red color
    public static var mainRed: UIColor {
        return UIColor.dynamicColor(light: UIColor(hex: "ED6E7E"), dark: UIColor(hex: "F85F71"))
    }

    /// the secondary  red color used for pop-up label over label in mainred components
    public static var shadowRed: UIColor {
        return UIColor(hex: "FDD2D7")
    }

    /// the secondary  red color used for pop-up label over label in mainred components
    public static var darkRed: UIColor {
        return UIColor(hex: "EB5C6E")
    }

    /// main fonts color used in any default font style
    public static var mainFontColor: UIColor {
        return UIColor.dynamicColor(light: UIColor(hex: "000000"), dark: UIColor(hex: "FFFFFF"))
    }

    /// background color for the app
    public static var mainBackgroundColor: UIColor {
        return UIColor.dynamicColor(light: UIColor(hex: "FFFFFF"), dark: UIColor(hex: "000000"))
    }

}
