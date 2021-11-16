//
//  CloseMessageCellViewModel.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import DesignSystem
import Networking

class CloseMessageCellViewModel: TableViewCellViewModel {
    var message: Message
    var title: String

    init(message: Message, title: String = "") {
        self.message = message
        self.title = title.isEmpty ? AkeeStrings.lblTitleMessageCloseMessages : title
    }
}
