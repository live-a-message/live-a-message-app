//
//  MapViewModel.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation
import Networking

class MapViewModel {
    private let messageService: MessageService
    private (set) var closeMessages: [Message] = []

    init(messageService: MessageService = LocalMessageService()) {
        self.messageService = messageService
        loadMessages()
    }

}

extension MapViewModel {
    func loadMessages() {
        let emptyLocation = Location(lat: "", lon: "")
        messageService.fetchMessages(location: emptyLocation, radius: 0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let messagesArray):
                self.closeMessages = messagesArray
            case .failure(let error):
                print("Could not load messages from file", error)
            }
        }
    }
}
