//
//  BlockedUsersViewModel.swift
//  Akee
//
//  Created by Vinicius Mesquita on 02/12/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Networking

protocol BlockedUserViewModelProtocol {
    var sections: [[BlockedUsersCellViewModel]] { get set }
    var didUpdateDataSource: (() -> Void)? { get set }
}

final class BlockedUsersViewModel: BlockedUserViewModelProtocol {
    var didUpdateDataSource: (() -> Void)?
    var sections: [[BlockedUsersCellViewModel]] = [[]] { didSet { self.didUpdateDataSource?() }}
    let service = CloudKitUserService()

    init() {
        getBlockedUsers()
    }

    func getBlockedUsers() {
        service.fetch(identifiers: UserData.shared.blockedIDs) { result in
            switch result {
            case .success(let users):
                let viewModel = users.compactMap({ BlockedUsersCellViewModel(user: $0) })
                self.sections.append(viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
