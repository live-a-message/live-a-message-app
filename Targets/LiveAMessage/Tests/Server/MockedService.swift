//
//  MockedService.swift
//  AkeeTests
//
//  Created by Fernando de Lucas da Silva Gomes on 04/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Networking

class MockedService: MessageService {

    var messages: [Message] = []

    static let shared = MockedService()

    var expectedResult: Bool = true

    func fetchMessages(location: Location, radius: Double, completion: @escaping ((Result<[Message], MessageServiceError>) -> Void)) {
        completion(.success(self.messages))
    }

    func addMessage(message: Message, completion: @escaping ((Result<Bool, MessageServiceError>) -> Void)) {
        if expectedResult {
            self.messages.append(message)
            completion(.success(true))
        } else {
            completion(.failure(.failedToWrite))
        }
    }

    func deleteMessage(message: Message, completion: @escaping ((Result<Bool, MessageServiceError>) -> Void)) {
        let countBefore = messages.count
        messages.removeAll { msg in
            msg.id == message.id
        }

        if countBefore > messages.count {
            completion(.success(true))
        } else {
            completion(.failure(.messageNotFound))
        }

    }

    func modifyMessage(message: Message, completion: ((Result<Bool, MessageServiceError>) -> Void)?) {
        completion?(.success(true))
    }
}
