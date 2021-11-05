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
//swiftlint:disable force_try

class CloudKitMessagesServiceTests: XCTestCase {

    let sut = CloudKitMessagesService(container: CKMockContainer())

    func testAddMessageSuccess() throws {
        // given
        let message = createMock(id: "231324325434132")
        // when
        sut.addMessage(message: message, completion: try success())
        // then
        waitForExpectations(timeout: 1.0)
    }

    func testDeleteMessageSuccess() throws {
        // given
        let message = createMock(id: "231324325434132")
        // when
        sut.deleteMessage(message: message, completion: try success())
        // then
        waitForExpectations(timeout: 1.0)
    }

    func testEleteMessageFailed() throws {
        // given
        let message = createMock(id: "invalid")
        // when
        sut.deleteMessage(message: message, completion: try failed(error: .messageNotFound))
        // then
        waitForExpectations(timeout: 1.0)
    }
}
extension CloudKitMessagesServiceTests {
    private func createRecordSuccessMock(id: String) -> CKRecord {
        let record = CKRecord(recordType: CKRecordType.Messages.rawValue)
        record["id"] = id
        record["content"] = "dsadsa"
        record["userId"] = "23123542312"
        record["location"] = CLLocation()
        record["status"] = "read"
        return record
    }

    private func createMock(id: String) -> Message {
        let record = createRecordSuccessMock(id: id)
        let message = try! CKMessage(record).message
        return message
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
