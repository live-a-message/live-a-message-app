//
//  CloseMessagesTests.swift
//  LiveAMessageTests
//
//  Created by Vinicius Mesquita on 14/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

@testable import Akee
import XCTest
import Networking

final class CloseMessageViewModelTests: XCTestCase {

    func test_addSectionRead_oneSection() {
        let sut = makeSut()
        let data = makeData(type: [.read, .read, .read])
        sut.setupCells(messages: data)
        XCTAssertEqual(sut.sections.count, 1)
    }

    func test_addSectionRead_TwoSections() {
        let sut = makeSut()
        let data = makeData(type: [.read, .unread])
        sut.setupCells(messages: data)
        XCTAssertEqual(sut.sections.count, 2)
    }
}

extension CloseMessageViewModelTests {

    typealias Sut = CloseMessagesViewModelProtocol
    typealias Data = [Message]

    private func makeData(type: [MessageStatus]) -> Data {
        return type.map {
            var message = Message(
                userId: "DEBUG",
                content: "",
                image: nil,
                location: Location(lat: .zero, lon: .zero)
            )
            message.status = $0
            return message
        }
    }

    private func makeSut() -> Sut {
        let viewModel = CloseMessagesViewModel()
        return viewModel
    }
}
