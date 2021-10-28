//
//  ProfileModel.swift
//  Akee
//
//  Created by Vinicius Mesquita on 26/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation

enum ProfileItemType: String {
    case termsOfService = "Terms Of Service"
    case logout = "Logout"
}

struct ProfileModel {
    let type: ProfileItemType
}
