//
//  CloseMessagesTests.swift
//  LiveAMessageTests
//
//  Created by Vinicius Mesquita on 14/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

@testable import LiveAMessage
import XCTest

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
    typealias Data = [CloseMessagesViewModel.Message]
    typealias Message = CloseMessagesViewModel.Message

    private func makeData(type: [CloseMessagesViewModel.Message.Status]) -> Data {
        return type.map {
            Message(
                id: "",
                content: "",
                location: .init(latitude: "", longitude: ""),
                status: $0
            )
        }
    }

    private func makeSut() -> Sut {
        let viewModel = CloseMessagesViewModel()
        return viewModel
    }
}
