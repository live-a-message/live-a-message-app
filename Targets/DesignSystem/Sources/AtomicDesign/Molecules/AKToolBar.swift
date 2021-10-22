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
        self.sizeToFit()
        self.tintColor = AKColor.mainRed
        self.barTintColor = .systemBackground
        self.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
