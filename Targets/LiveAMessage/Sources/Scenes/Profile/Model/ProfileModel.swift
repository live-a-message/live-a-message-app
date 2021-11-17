//
//  ProfileModel.swift
//  Akee
//
//  Created by Vinicius Mesquita on 26/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation

enum ProfileItemType {
    case termsOfService
    case logout
    case anonymous
    case allowAR

    var localized: String {
        switch self {
        case .termsOfService:
            return AkeeStrings.lblTermsOfServiceProfile
        case .logout:
            return AkeeStrings.lblLogoutProfile
        case .allowAR:
            return AkeeStrings.lblAllowAR
        case .anonymous:
            return "Ativar modo anonimo"
        }
    }
}

struct ProfileModel {
    let type: ProfileItemType
}
