//
//  CloseMessagesViewModel.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem
import Networking

protocol CloseMessagesViewModelProtocol {
    var sections: [[CloseMessageCellViewModel]] { get set }
    var sectionsTitle: [CloseMessagesViewModel.SectionTitle] { get set }
    var service: MessageService { get }
    func setupCells(messages: [Message])
}

class CloseMessagesViewModel: NSObject, CloseMessagesViewModelProtocol {

    var sections = [[CloseMessageCellViewModel]]()
    var sectionsTitle = [SectionTitle]()

    let service: MessageService = CloudKitMessagesService()

    init(messages: [Message] = []) {
        super.init()
        setupCells(messages: messages)
    }

    func setupCells(messages: [Message]) {
        sections = [[CloseMessageCellViewModel]]()
        let filteredMessages = messages.filter {
            !UserData.shared.blockedIDs.contains($0.userId)
        }
        let read = filteredMessages.filter { $0.status == .read }
        let unread = filteredMessages.filter { $0.status == .unread }

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
        messages.forEach { section.append(CloseMessageCellViewModel(message: $0)) }
        sectionsTitle.append(title)
        sections.append(section)
    }

}

extension CloseMessagesViewModel {
    enum SectionTitle: String {
        case read
        case unread
    }
}
