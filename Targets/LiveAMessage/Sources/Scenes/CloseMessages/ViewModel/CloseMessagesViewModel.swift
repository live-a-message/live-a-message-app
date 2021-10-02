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

protocol CloseMessagesViewModelProtocol: UITableViewDelegate, UITableViewDataSource {
    var sections: [[CloseMessageCellViewModel]] { get set }
    var coordinator: Coordinator? { get set }
    func setupCells(messages: [Message])
}

class CloseMessagesViewModel: NSObject, CloseMessagesViewModelProtocol {

    var sections = [[CloseMessageCellViewModel]]()
    var sectionTitles = [SectionTitle]()
    weak var coordinator: Coordinator?

    init(messages: [Message] = []) {
        super.init()
        setupCells(messages: messages)
    }

    func setupCells(messages: [Message]) {
        let filteredMessages = messages.filter {
            !UserData.shared.blockedIDs.contains($0.userId)
        }
        let unreaded = filteredMessages.filter { $0.status == .read }
        let readead = filteredMessages.filter { $0.status == .unread }

        addSection(
            title: .read,
            messages: unreaded
        )
        addSection(
            title: .unread,
            messages: readead
        )
    }

    func addSection(title: SectionTitle, messages: [Message]) {
        guard !messages.isEmpty else { return }
        var section = [CloseMessageCellViewModel]()
        messages.forEach { section.append(CloseMessageCellViewModel(message: $0)) }
        sectionTitles.append(title)
        sections.append(section)
    }

}

extension CloseMessagesViewModel: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = sections[indexPath.section]
        let cellViewModel = cells[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellViewModel.identifier,
            for: indexPath
        ) as? CloseMessageTableViewCell else { return UITableViewCell() }
        cell.setup(viewModel: cellViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = sections[indexPath.section][indexPath.row].message
        coordinator?.showMessageDetails(with: message)
    }
}

extension CloseMessagesViewModel {
    enum SectionTitle: String {
        case read = "Readed Messages"
        case unread = "Unreaded messages"
    }
}
