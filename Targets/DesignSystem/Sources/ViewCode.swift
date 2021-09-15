//
//  ViewCode.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation

public protocol ViewCode {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}
