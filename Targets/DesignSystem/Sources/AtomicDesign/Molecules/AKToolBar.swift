//
//  AKToolBar.swift
//  DesignSystem
//
//  Created by Fernando de Lucas da Silva Gomes on 15/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public class AKToolBar: UIToolbar {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.barStyle = .default
        self.sizeToFit()
//        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(for items: [AKButton]) {
        let buttons = items.map {
            return $0.toBarButton()
        }
        self.setItems(buttons, animated: false )
    }

}

extension AKButton {
    func toBarButton() -> UIBarButtonItem {
        return UIBarButtonItem(customView: self)
    }
}
