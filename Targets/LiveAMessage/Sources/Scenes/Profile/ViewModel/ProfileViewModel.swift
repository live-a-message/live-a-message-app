//
//  ProfileViewModel.swift
//  DesignSystem
//
//  Created by Tales Conrado on 20/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation

protocol ProfileViewModelProtocol {
    var sections: [[ProfileCellViewModel]] { get set }
}

struct ProfileViewModel: ProfileViewModelProtocol {

    private let items: [ProfileModel] = [
        ProfileModel(type: .termsOfService)
    ]

    var sections: [[ProfileCellViewModel]] = []

    init() {
        let firstSection = items.map({ ProfileCellViewModel(model: $0) })
        sections.append(firstSection)
    }
}
