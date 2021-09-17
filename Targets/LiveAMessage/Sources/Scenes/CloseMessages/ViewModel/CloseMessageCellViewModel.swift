//
//  CloseMessageCellViewModel.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation
import Networking

protocol TableViewCell {
    var identifier: String { get }
}

class CloseMessageCellViewModel: TableViewCell {
    lazy var identifier: String = String(describing: type(of: self))
    var message: Message

    init(message: Message) {
        self.message = message
    }
}
