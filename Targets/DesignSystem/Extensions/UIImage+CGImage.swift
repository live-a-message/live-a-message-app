//
//  UIImage+CGImage.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 14/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = .zero) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, .zero)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
