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

    let sut = CloudKitMessagesService(container: CKMockContainer())

    func test_addMessage_toBeSuccess() throws {
        // given
        let message = createMock(id: "231324325434132")
        // when
        sut.addMessage(message: message, completion: try success())
        // then
        waitForExpectations(timeout: 1.0)
    }

    func test_deleteMessage_toBeSuccess() throws {
        // given
        let message = createMock(id: "231324325434132")
        // when
        sut.deleteMessage(message: message, completion: try success())
        // then
        waitForExpectations(timeout: 1.0)
    }

    func test_deleteMessage_toBeFailed() throws {
        // given
        let message = createMock(id: "invalid")
        // when
        sut.deleteMessage(message: message, completion: try failed(error: .messageNotFound))
        // then
        waitForExpectations(timeout: 1.0)
    }
}
extension CloudKitMessagesServiceTests {
    private func createMock(id: String) -> Message {
        Message(
            id: id,
            userId: UUID().uuidString,
            content: "TESTE", image: nil,
            location: .init(lat: 1.0, lon: 1.0),
            imageAsset: nil
        )
    }

    private func success() throws -> ((Result<Bool, MessageServiceError>) -> Void) {
        let excpt = expectation(description: "success")
        return { result in
            XCTAssertEqual(result, .success(true))
            excpt.fulfill()
        }
    }

    private func failed(error: MessageServiceError) throws -> ((Result<Bool, MessageServiceError>) -> Void) {
        let excpt = expectation(description: "failed")
        return { result in
            XCTAssertEqual(result, .failure(error))
            excpt.fulfill()
        }
    }
}
