//
//  Colors.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 14/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

public class Colors: UIColor {
  public convenience init(red: Int, green: Int, blue: Int) {
      self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }

  /// the default red color
  public static var mainRed: UIColor {
    return UIColor { (traitCollection) -> UIColor in
              return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "ED6E7E") : UIColor(hex: "F85F71")
      }
  }

  /// the secondary  red color used for pop-up label over label in mainred components
  public static var shadowRed: UIColor {
    return UIColor(hex: "FDD2D7")
  }
}

extension UIColor {

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }

    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format: "#%06x", rgb)
    }
}
