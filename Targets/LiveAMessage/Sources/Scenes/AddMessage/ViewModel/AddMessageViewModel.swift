//
//  AddMessageViewModel.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Networking

protocol AddMessageViewModelProtocol: AnyObject {
    var messageService: MessageService { get }
    func saveMessage(
        with content: String,
        image: String?
    )
}

class AddMessageViewModel: AddMessageViewModelProtocol {
    var messageService: MessageService = LocalMessageService()
    
    func saveMessage(
        with content: String,
        image: String?
    ) {
        let message = Message(
            userId: "",
            content: content,
            image: image,
            location: Location(lat: "", lon: "")
        )
        
        messageService.addMessage(message: message) { result in }
    }

}
