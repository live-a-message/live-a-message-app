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

    var sections: [[ProfileCellViewModel]] = []

    init() {
        let items = makeItems {
            ProfileModel(type: .termsOfService)
        }
        let firstSection = items.map({ ProfileCellViewModel(model: $0) })
        sections.append(firstSection)
        sections.append(contentsOf: Array(repeating: [], count: 8))
        let lastSection = [ProfileCellViewModel(model: ProfileModel(type: .logout))]
        sections.append(lastSection)
    }

    func makeItems(@ItemsBuilder _ content: () -> [ProfileModel]) -> [ProfileModel] {
        content()
    }
}

@resultBuilder
struct ItemsBuilder {
    static func buildBlock() -> [ProfileModel] { [] }
}
extension ItemsBuilder {
    static func buildBlock(_ items: ProfileModel...) -> [ProfileModel] {
        items
    }
}
