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

    override func setUp() {
        UserData.shared.blockedIDs = []
        UserData.shared.readMessages = []
    }

    func test_addSectionRead_oneSection() {
        let sut = makeSut()
        let data = makeData(type: [.read, .read, .read])
        sut.setupCells(messages: data)
        XCTAssertEqual(sut.sections.count, 2)
    }

    func test_addSectionRead_TwoSections() {
        let sut = makeSut()
        let data = makeData(type: [.read, .unread])
        sut.setupCells(messages: data)
        XCTAssertEqual(sut.sections.count, 3)
    }
}

extension CloseMessageViewModelTests {

    typealias Sut = CloseMessagesViewModelProtocol
    typealias Data = [Message]

    private func makeData(type: [MessageStatus]) -> Data {
        return type.map { type in
            let message = Message(
                userId: "DEBUG",
                content: "",
                image: nil,
                location: Location(lat: .zero, lon: .zero),
                imageAsset: nil
            )
            if type == .read {
                UserData.shared.readMessages.append(message.id)
            }
            return message
        }
    }

    private func makeSut() -> Sut {
        let viewModel = CloseMessagesViewModel(currentLocation: .init(lat: 12312, lon: 231231))
        return viewModel
    }
}
