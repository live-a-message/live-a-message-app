//
//  Colors.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 14/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
//
//extension UIColor {
//
//}

class Colors: UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
      self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }

  /// the default red color
  static var mainRed: UIColor {
    return UIColor { (traitCollection) -> UIColor in
              return traitCollection.userInterfaceStyle == .dark ? UIColor(red: CGFloat(237) / 255.0, green: CGFloat(110) / 255.0, blue: CGFloat(126) / 255.0, alpha: 1.0) : UIColor(red: CGFloat(248) / 255.0, green: CGFloat(95) / 255.0, blue: CGFloat(113) / 255.0, alpha: 1.0)
      }
  }
}
