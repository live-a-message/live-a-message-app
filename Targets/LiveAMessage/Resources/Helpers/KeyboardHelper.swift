//
//  KeyboardHelper.swift
//  DesignSystem
//
//  Created by Fernando de Lucas da Silva Gomes on 21/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

open class KeyBoardManager {

    private var screenBounds: CGRect {
        return UIScreen.main.bounds
    }

    public var keyboardWillChangeFrame: ((
        _ isHiding: Bool,
        _ keyBoardHeight: CGFloat,
        _ animationDuration: TimeInterval,
        _ animationCurve: UIView.AnimationOptions) -> Void)?

    public init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc public func keyboardWillHide(notification: NSNotification) {
        guard let animationDuration = notification.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval,
              let animationCurveRawValue = notification.userInfo?["UIKeyboardAnimationCurveUserInfoKey"] as? UInt else {
            return
        }

        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRawValue)

        keyboardWillChangeFrame?(true, 0, animationDuration, animationCurve)
    }

    @objc public func keyboardNotification(notification: NSNotification) {

        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect,
              let animationDuration = notification.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval,
              let animationCurveRawValue = notification.userInfo?["UIKeyboardAnimationCurveUserInfoKey"] as? UInt else {
            return
        }

        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRawValue)
        let keyboardAttached = screenBounds.maxX == keyboardFrame.maxX &&
        screenBounds.maxY == keyboardFrame.maxY &&
        screenBounds.width == keyboardFrame.width
        if keyboardAttached {
            keyboardWillChangeFrame?(false, keyboardFrame.height, animationDuration, animationCurve)
        } else {
            keyboardWillChangeFrame?(false, 0, animationDuration, animationCurve)
        }
    }
}
