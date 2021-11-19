//
//  ProfileCellViewModel.swift
//  Akee
//
//  Created by Vinicius Mesquita on 25/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import DesignSystem
import UIKit
import Networking

class ProfileCellViewModel: TableViewCellViewModel {
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

    @objc func didTapAnonymousSwitch() {
        print("Change")
    }

    @objc func didTapAllowSwitch(sender: UISwitch) {
        UserData.shared.allowAR = sender.isOn
    }
}
