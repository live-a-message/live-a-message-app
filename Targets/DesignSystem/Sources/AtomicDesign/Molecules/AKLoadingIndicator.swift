//
//  AKLoadingIndicator.swift
//  DesignSystem
//
//  Created by Vinicius Mesquita on 06/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public class AKLoadingIndicator: UIActivityIndicatorView {

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        self.style = .large
        self.color = AKColor.mainRed
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func set(_ event: Event) {
        DispatchQueue.main.async {
            switch event {
            case .load:
                self.startAnimating()
            case .stop:
                self.stopAnimating()
            }
        }
    }

}

extension AKLoadingIndicator {
    public enum Event {
        case load
        case stop
    }
}
