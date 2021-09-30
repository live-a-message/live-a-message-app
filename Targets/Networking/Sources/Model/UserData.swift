//
//  UserData.swift
//  Akee
//
//  Created by Vinicius Mesquita on 30/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation

public class UserData {

    public static let shared = UserData()
    private let defaults = UserDefaults.standard

    public var isLoggedIn: Bool {
        defaults.bool(forKey: Keys.isLoggedIn.rawValue)
    }

    public var id: String? {
        defaults.string(forKey: Keys.id.rawValue)
    }
    
    public var name: String? {
        defaults.string(forKey: Keys.name.rawValue)
    }

    public var email: String? {
        defaults.string(forKey: Keys.email.rawValue)
    }

    private init() { }

    public func save(user: User) {
        defaults.setValue(user.email, forKey: Keys.email.rawValue)
        defaults.setValue(user.name, forKey: Keys.name.rawValue)
        defaults.setValue(user.id, forKey: Keys.id.rawValue)
        defaults.setValue(true, forKey: Keys.isLoggedIn.rawValue)
    }
}

extension UserData {

    enum Keys: String {
        case isLoggedIn = "isLoggedIn"
        case email      = "email"
        case name       = "name"
        case id         = "id"
    }

}
