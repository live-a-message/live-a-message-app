//
//  AnimationView.swift
//  Akee
//
//  Created by Albert on 19/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import Lottie
import TinyConstraints

public class AKAnimationView: UIView, ViewCode {

    static let instance = AKAnimationView()

    lazy var animationView: AnimationView = {
        let view = AnimationView()
        view.contentMode = .scaleAspectFit
        view.alpha = 0
        return view
    }()

    private init() {
        let screenRect = UIScreen.main.bounds
        let width = screenRect.width + screenRect.origin.x
        let height = screenRect.height + screenRect.origin.y

        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public class func animateAboveAll(with animation: String) {
        instance.animationView.animation = .named(animation)
        instance.animateFadeIn()
        UIApplication.shared.delegate?.window??.addSubview(instance)
        instance.animationView.play { _ in
            instance.removeFromSuperview()
        }
    }

    private func animateFadeIn() {
        UIView.animate(withDuration: 0.8) {
            self.animationView.alpha = 1
        }
    }

    public func buildHierarchy() {
        addSubview(animationView)
    }

    public func setupConstraints() {
        animationView.edgesToSuperview()
    }

    public func configureViews() {
        buildHierarchy()
        setupConstraints()
    }
}
