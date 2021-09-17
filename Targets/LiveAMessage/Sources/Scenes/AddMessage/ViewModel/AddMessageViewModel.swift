//
//  AddMessageViewModel.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation

protocol AddMessageViewModelProtocol: AnyObject {
    func saveMessage()
}

class AddMessageViewModel: AddMessageViewModelProtocol {
    func saveMessage() {}
}
