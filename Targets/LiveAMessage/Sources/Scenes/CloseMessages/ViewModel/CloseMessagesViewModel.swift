//
//  CloseMessagesViewModel.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem
import Networking
import CoreLocation

protocol CloseMessagesViewModelProtocol {
    var sections: [[CloseMessageCellViewModel]] { get set }
    var sectionsTitle: [CloseMessagesViewModel.SectionTitle] { get set }
    var service: MessageService { get }
    var currentLocation: Location { get }
    var didDataChange: (() -> Void)? { get set }
    func setupCells(messages: [Message])
}

class CloseMessagesViewModel: NSObject, CloseMessagesViewModelProtocol {
    var didDataChange: (() -> Void)?
    var sections = [[CloseMessageCellViewModel]]() { didSet { didDataChange?() } }
    var sectionsTitle = [SectionTitle]()
    var currentLocation: Location

    let service: MessageService = CloudKitMessagesService()

    init(messages: [Message] = [], currentLocation: Location) {
        self.currentLocation = currentLocation
        super.init()
        setupCells(messages: messages)
    }

    func setupCells(messages: [Message]) {
        sections = [[]]
        let filteredMessages = messages.filter {
            !UserData.shared.blockedIDs.contains($0.userId)
        }
        let readMessages = UserData.shared.readMessages
        let read = filteredMessages.filter { readMessages.contains($0.id) }
        let unread = filteredMessages.filter { !readMessages.contains($0.id) }

        addSection(
            title: .read,
            messages: read
        )
        addSection(
            title: .unread,
            messages: unread
        )
    }

    func addSection(title: SectionTitle, messages: [Message]) {
        guard !messages.isEmpty else { return }
        var section = [CloseMessageCellViewModel]()
        messages.forEach { section.append(CloseMessageCellViewModel(message: $0,
                                                                    title: calculateDistance(
                                                                        from: $0.location,
                                                                        to: self.currentLocation)
                                                                   )) }
        sectionsTitle.append(title)
        sections.append(section)
    }

    private func calculateDistance(from firstLocation: Location, to secondLocation: Location) -> String {
        let firstCLLocation = CLLocation(latitude: firstLocation.lat, longitude: firstLocation.lon)
        let secondCLLocation = CLLocation(latitude: secondLocation.lat, longitude: secondLocation.lon)
        let distance = firstCLLocation.distance(from: secondCLLocation)

        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1

        let inKilometers = Double(distance) / 1000
        if distance < 10_000 {
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            formatter.maximumIntegerDigits = 1
        } else if distance < 100_000 {
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 1
            formatter.maximumIntegerDigits = 2
        } else {
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            formatter.maximumIntegerDigits = .max
        }

        return (formatter.string(for: inKilometers) ?? "") + " km"
    }
}

extension CloseMessagesViewModel {
    enum SectionTitle: String {
        case read
        case unread

        var title: String {
            switch self {
            case .read: return AkeeStrings.sectionReadCloseMessages
            case .unread: return AkeeStrings.sectionUnreadCloseMessages
            }
        }
    }
}
