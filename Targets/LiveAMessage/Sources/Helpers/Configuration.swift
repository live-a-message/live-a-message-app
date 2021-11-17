//
//  Configuration.swift
//  Akee
//
//  Created by Fernando de Lucas da Silva Gomes on 16/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import Networking

// This class allows the in-memory storage of UserDefaults configurations that can
// eventually be used many times in the app, with the purpose of better performance.
class Configuration: UserDataDelegate {

    static let shared = Configuration()
    var allowAR: Bool
    var name: String?

    init() {
        self.allowAR = UserData.shared.allowAR
        self.name = UserData.shared.name
    }

    func didValuesUpdate() {
        self.allowAR = UserData.shared.allowAR
        self.name = UserData.shared.name
    }
}
