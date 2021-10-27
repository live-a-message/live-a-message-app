//
//  DeleteViewModel.swift
//  Akee
//
//  Created by Tales Conrado on 07/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import Networking
import OSLog

class DeleteViewModel {
    let message: Message
    private let service: MessageService

    init(message: Message, service: MessageService) {
        self.message = message
        self.service = service
    }

    func delete(completion: @escaping ((Bool) -> Void)) {
        service.deleteMessage(message: message) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print(error)
                os_log("Error: Delete message request failed")
                completion(false)
            }
        }
    }
}
