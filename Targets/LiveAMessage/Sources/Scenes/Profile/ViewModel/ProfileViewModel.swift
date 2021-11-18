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
}

class ProfileViewModel: ProfileViewModelProtocol {

    var emptyState = EmptyStateViewModel(
        icon: AkeeAsset.pinzinhoEmptyState.image,
        title: "Olá",
        description: "Para que consiga interagir com outros usuários é preciso que inicie uma sessão"
    )

    let items: [ProfileModel] = [
        ProfileModel(type: .termsOfService)
    ]

    var sections: [[ProfileCellViewModel]] = [[]]

    func didSelectSessionButton() {

    }

    init() {
        guard UserData.shared.isLoggedIn else { return }
        let firstSection = items.map({ ProfileCellViewModel(model: $0) })
        sections.append(firstSection)
        sections.append(contentsOf: Array(repeating: [], count: 8))
        let lastSection = [ProfileCellViewModel(model: ProfileModel(type: .logout))]
        sections.append(lastSection)
    }
}
