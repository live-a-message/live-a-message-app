//
//  MessageDetailsViewModel.swift
//  Akee
//
//  Created by Albert on 29/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import Networking

protocol MessageDetailsViewModelProtocol: UITableViewDelegate, UITableViewDataSource {
    var message: Message { get }
    var canDelete: Bool { get }
    func readMessage()
}

class MessageDetailsViewModel: NSObject, MessageDetailsViewModelProtocol {
    var message: Message

    var canDelete: Bool {
        message.userId == UserData.shared.id
    }

    init(message: Message) {
        self.message = message
    }

    func readMessage() {
        UserData.shared.readMessages.append(message.id)
    }
}

extension MessageDetailsViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as? MessageDetailMapTableViewCell else {
                return UITableViewCell()
            }
            cell.fill(with: message.location)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.fill(message: message.content)
            return cell
        }
    }

}
