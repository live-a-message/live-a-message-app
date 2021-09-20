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

}
