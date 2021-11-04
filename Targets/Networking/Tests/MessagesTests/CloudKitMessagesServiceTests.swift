//
//  CloudKitMessagesServiceTests.swift
//  AkeeTests
//
//  Created by Vinicius Mesquita on 04/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import XCTest
@testable import Networking
import CloudKit

class CloudKitMessagesServiceTests: XCTestCase {

    var container: CKMockContainer!
    var sut: CloudKitMessagesService!

    override func setUp() {
        container = CKMockContainer(shouldThrowError: true)
        sut = CloudKitMessagesService(container: container)
    }

    func testDeleteMessageSuccess() throws {
        let message = createMock()
        let completedExpectation = expectation(description: "Completed")
        // when
        let completion: ((Result<Bool, MessageServiceError>) -> Void) = { result in
            assert(result == .success(true))
            completedExpectation.fulfill()
        }
        // then
        sut.deleteMessage(message: message, completion: completion)
        waitForExpectations(timeout: 1.0)
    }

    func testDeleteMessageFailed() throws {
        let message = createMock()
        container = CKMockContainer(shouldThrowError: true)
        sut = CloudKitMessagesService(container: container)
        let completedExpectation = expectation(description: "Completed")

        let completion: ((Result<Bool, MessageServiceError>) -> Void) = { result in
            assert(result == .failure(.networkError))
            completedExpectation.fulfill()
        }
        sut.deleteMessage(message: message, completion: completion)
        waitForExpectations(timeout: 1.0)
    }

}
extension CloudKitMessagesServiceTests {
    private func createMock() -> Message {
        Message(
            id: "100",
            userId: "",
            content: "",
            image: "",
            location: .init(lat: 1.0, lon: 1.0),
            imageAsset: nil,
            status: .read
        )
    }
}
