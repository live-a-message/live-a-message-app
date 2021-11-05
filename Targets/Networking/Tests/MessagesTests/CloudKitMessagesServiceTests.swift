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

    let sut = CloudKitMessagesService(container: CKMockContainer.default())

    func test() throws {
        let message = createMock()
        let completion: ((Result<Bool, MessageServiceError>) -> Void) = { result in
        }

        sut.deleteMessage(message: message, completion: completion)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
extension CloudKitMessagesServiceTests {
    private func createMock() -> Message {
        Message(
            id: "",
            userId: "",
            content: "",
            image: "",
            location: .init(lat: 1.0, lon: 1.0),
            imageAsset: nil,
            status: .read
        )
    }
}







