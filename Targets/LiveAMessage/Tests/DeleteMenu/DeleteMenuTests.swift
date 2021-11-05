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

    private var service = MockedService.shared
    var sut: DeleteViewModel!

    override func setUp() {
        service.messages = [Message(id: "TestId",
                                   userId: "User",
                                   content: "Content",
                                   image: nil,
                                   location: Location(lat: 0.0, lon: 0.0),
                                   imageAsset: nil,
                                   status: .unread)]
    }

    override func tearDown() {
        service.messages = []
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
