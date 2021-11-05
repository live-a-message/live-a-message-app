//
//  DeleteMenuTests.swift
//  AkeeTests
//
//  Created by Tales Conrado on 04/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import XCTest
import Networking
@testable import Akee

class DeleteMenuTests: XCTestCase {

    private var service: MockedMessageService!
    var sut: DeleteViewModel!

    private class MockedMessageService: MessageService {
        var messages: [Message] = [Message(id: "TestId",
                                           userId: "User",
                                           content: "Content",
                                           image: nil,
                                           location: Location(lat: 0.0, lon: 0.0),
                                           imageAsset: nil,
                                           status: .unread)]

        func fetchMessages(location: Location, radius: Double, completion: @escaping ((Result<[Message], MessageServiceError>) -> Void)) { }
        func addMessage(message: Message, completion: @escaping ((Result<Bool, MessageServiceError>) -> Void)) { }

        func deleteMessage(message: Message, completion: @escaping ((Result<Bool, MessageServiceError>) -> Void)) {
            messages.removeAll { $0.id == message.id }
            if messages.isEmpty {
                completion(.success(true))
            } else {
                completion(.failure(.messageNotFound))
            }
        }

        func modifyMessage(message: Message, completion: ((Result<Bool, MessageServiceError>) -> Void)?) { }
    }

    override func setUp() {
        service = MockedMessageService()
    }

    override func tearDown() {
        service = nil
    }

    func test_when_deleting_valid_message_should_complete_with_success() {
        let validMessage = service.messages.first
        sut = DeleteViewModel(message: validMessage!, service: service)
        let deleteExpectation = expectation(description: "delete")
        sut.delete { didDelete in
            XCTAssert(didDelete)
            deleteExpectation.fulfill()
        }
        wait(for: [deleteExpectation], timeout: 2)
    }

    func test_when_deleting_invalidMessage_should_not_succeed() {
        let invalidMessage = Message(id: "Invalid",
                                      userId: "User",
                                      content: "Content",
                                      image: nil,
                                      location: Location(lat: 0.0, lon: 0.0),
                                      imageAsset: nil,
                                      status: .unread)
        sut = DeleteViewModel(message: invalidMessage, service: service)
        let deleteExpectation = expectation(description: "delete")
        sut.delete { didDelete in
            XCTAssertFalse(didDelete)
            deleteExpectation.fulfill()
        }

        wait(for: [deleteExpectation], timeout: 2)
    }

}
