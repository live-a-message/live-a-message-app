//
//  ProfileViewModel.swift
//  DesignSystem
//
//  Created by Tales Conrado on 20/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import DesignSystem
import Networking

protocol ProfileViewModelProtocol {
    var sections: [[ProfileCellViewModel]] { get set }
    var emptyState: EmptyStateViewModel { get set }
    func loadSections()
}

class ProfileViewModel: ProfileViewModelProtocol {

    var emptyState = EmptyStateViewModel(
        icon: AkeeAsset.pinzinhoEmptyState.image,
        title: AkeeStrings.lblNotLoginInTitle,
        description: AkeeStrings.lblNotLoginInDescription
    )

    let items: [ProfileModel] = [
      ProfileModel(type: .termsOfService), ProfileModel(type: .blockedUsers)
    ]

    var sections: [[ProfileCellViewModel]] = [[]]

    func didSelectSessionButton() {

    }

    init() {
        loadSections()
    }

    public func loadSections() {
        guard UserData.shared.isLoggedIn else {
            sections = [[]]
            return
        }
        sections = [[]]
        let firstSection = items.map({ ProfileCellViewModel(model: $0) })
        sections.append(firstSection)
        sections.append(contentsOf: Array(repeating: [], count: 8))
        let lastSection = [ProfileCellViewModel(model: ProfileModel(type: .logout))]
        sections.append(lastSection)
    }
}
