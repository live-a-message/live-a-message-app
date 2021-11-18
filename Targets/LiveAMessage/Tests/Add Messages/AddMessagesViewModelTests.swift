//
//  AddMessagesViewModelTests.swift
//  Akee
//
//  Created by Fernando de Lucas da Silva Gomes on 04/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

@testable import Akee
import XCTest
import Networking
import CoreLocation

class AddMessagesViewModelTests: XCTestCase {

    typealias Sut = AddMessageViewModel

    let server = MockedService.shared

    private var currentLocation: CLLocation? = CLLocation(latitude: .zero, longitude: .zero)

    override func setUp() {
        currentLocation = CLLocation(latitude: .zero,
                                     longitude: .zero)
        server.messages = []
        server.expectedResult = true
    }

    func test_addMessage_toBeSaved() {
        let sut = makeSut()

        sut.saveMessage(with: "Valid", image: nil)

        XCTAssertEqual(server.messages.count, 1)
    }

    func test_addMessages_toBeEqualTheNumberOfMessages() {
        let sut = makeSut()

        sut.saveMessage(with: "Valid", image: nil)
        sut.saveMessage(with: "Valid", image: nil)

        XCTAssertEqual(server.messages.count, 2)

    }

    func test_messageContent_toBeEqual() {
        let sut = makeSut()

        sut.saveMessage(with: "Valid", image: nil)

        XCTAssertEqual(server.messages.first?.content, "Valid")
    }

    func test_addMessageWithLocationNil_toNotSave() {
        self.currentLocation = nil
        let sut = makeSut()

        sut.saveMessage(with: "Valid", image: nil)

        XCTAssertTrue(server.messages.isEmpty)
    }

    func test_addMessageWithServerError_toNotSave() {
        server.expectedResult = false
        let sut = makeSut()

        sut.saveMessage(with: "Valid", image: nil)

        XCTAssertTrue(server.messages.isEmpty)
    }

    func test_setLocationWithValidObject_toUpdateCurrentLocation() {
        let sut = makeSut()
        sut.currentLocation = nil
        let validNotification = makeValidNotification()

        sut.setLocation(validNotification)

        XCTAssertNotNil(sut.currentLocation)
    }

    func test_setLocationWithInvalidObject_toNotUpdateCurrentLocation() {
        let sut = makeSut()
        sut.currentLocation = nil
        let validNotification = makeInvalidNotification()

        sut.setLocation(validNotification)

        XCTAssertNil(sut.currentLocation)
    }

    func test_setLocationUpdate_toBeAsExpectedLocation() {
        let sut = makeSut()
        let validNotification = makeValidNotification()
        let expectedLocation = CLLocation(latitude: 360, longitude: 360)

        sut.setLocation(validNotification)

        XCTAssertTrue(expectedLocation.expectDistance(to: sut.currentLocation!, be: 0.0))
    }
}

extension AddMessagesViewModelTests {
    func makeSut() -> Sut {
        let viewModel = AddMessageViewModel()
        viewModel.messageService = server
        viewModel.currentLocation = self.currentLocation
        return viewModel
    }

    func makeValidNotification() -> Notification {
        let location = CLLocation(latitude: 360, longitude: 360)
        return Notification(name: .updateLocation, object: location, userInfo: nil)
    }

    func makeInvalidNotification() -> Notification {
        return Notification(name: .updateLocation, object: String("Fail"), userInfo: nil)
    }
}

extension CLLocation {
    func expectDistance(to secondaryLocation: CLLocation, be meters: Double) -> Bool {
        return self.distance(from: secondaryLocation) == meters
    }
}
