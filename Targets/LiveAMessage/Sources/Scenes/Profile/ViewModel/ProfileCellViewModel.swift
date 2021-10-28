//
//  ProfileCellViewModel.swift
//  Akee
//
//  Created by Vinicius Mesquita on 25/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import DesignSystem

struct ProfileCellViewModel: TableViewCellViewModel {
    private let model: ProfileModel

    var title: String {
        model.type.localized
    }

    var type: ProfileItemType {
        model.type
    }

    init(model: ProfileModel) {
        self.model = model
    }
}
