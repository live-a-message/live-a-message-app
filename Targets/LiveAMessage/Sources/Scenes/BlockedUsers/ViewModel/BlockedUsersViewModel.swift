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
    func unblockUser(id: String)
    
    var delegate: BlockedUserViewModelDelegate? { get set }
}

protocol BlockedUserViewModelDelegate: AnyObject {
    func success()
    func failure()
}

final class BlockedUsersViewModel: BlockedUserViewModelProtocol {
    weak var delegate: BlockedUserViewModelDelegate?

    var didUpdateDataSource: (() -> Void)?
    var sections: [[BlockedUsersCellViewModel]] = [[]] { didSet { self.didUpdateDataSource?() }}
    let service = CloudKitUserService()
    private var blockedUsers = [User]()

    init() {
        getBlockedUsers()
    }

    func getBlockedUsers() {
        service.fetch(identifiers: UserData.shared.blockedIDs) { result in
            switch result {
            case .success(let users):
                self.blockedUsers = users
                let viewModel = users.compactMap({ BlockedUsersCellViewModel(user: $0) })
                self.sections.append(viewModel)
                self.delegate?.success()
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.failure()
            }
        }
    }
    
    func unblockUser(id: String) {
        service.unblock(userId: id) { result in
            switch result {
            case .success:
                print("success")
                self.delegate?.success()
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.failure()
            }
        }
    }
}
