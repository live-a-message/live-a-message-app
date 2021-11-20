//
//  UIColor+BackgroundColor.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 20/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

extension UIButton {
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: .zero, y: .zero, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(image(withColor: color), for: state)
    }
}

extension UIButton {

    func setIcon(imageIcon: ButtonIcon) {
        if let highlighted = imageIcon.highlighted?.rawValue {
            if let systemImage = UIImage(systemName: highlighted) {
                self.setImage(systemImage, for: .highlighted)
            } else if let normalImage = UIImage(named: highlighted) {
                self.setImage(normalImage, for: .highlighted)
            }
        }
        if let normal = imageIcon.normal?.rawValue {
            if let systemImage = UIImage(systemName: normal) {
                self.setImage(systemImage, for: .normal)
            } else if let normalImage = UIImage(named: normal) {
                self.setImage(normalImage, for: .normal)
            }
        }
    }
}
