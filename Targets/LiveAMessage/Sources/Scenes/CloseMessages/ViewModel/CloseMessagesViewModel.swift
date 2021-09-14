//
//  CloseMessagesViewModel.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

protocol CloseMessagesViewModelProtocol: UITableViewDelegate, UITableViewDataSource {
    var sections: [[CloseMessageCellViewModel]] { get set }
    func setupCells(messages: [CloseMessagesViewModel.Message])
}

class CloseMessagesViewModel: NSObject, CloseMessagesViewModelProtocol {

    var sections = [[CloseMessageCellViewModel]]()
    var sectionTitles = [SectionTitle]()

    init(messages: [Message] = []) {
        super.init()
        setupCells(messages: messages)
    }

    func setupCells(messages: [Message]) {
        let unreaded = messages.filter { $0.status == .read }
        let readead = messages.filter { $0.status == .unread }

        addSection(
            title: .read,
            messages: unreaded
        )
        addSection(
            title: .unread,
            messages: readead
        )
    }

    func addSection(title: SectionTitle, messages: [CloseMessagesViewModel.Message]) {
        guard !messages.isEmpty else { return }
        var section = [CloseMessageCellViewModel]()
        messages.forEach { section.append(CloseMessageCellViewModel(message: $0)) }
        sectionTitles.append(title)
        print(title)
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

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.contentView.backgroundColor = .systemPink
    }
}

extension CloseMessagesViewModel {

    enum SectionTitle: String {
        case read = "Readed Messages"
        case unread = "Non read"
    }

    struct Message {
        let id: String
        let content: String
        let location: Location
        let status: Status
        
        enum Status {
            case read
            case unread
        }

    }
    struct Location {
        let latitude: String
        let longitude: String
    }
}
