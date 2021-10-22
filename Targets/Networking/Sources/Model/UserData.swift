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
        defaults.bool(forKey: Key.isLoggedIn.rawValue)
    }

    public var agreeWithTerms: Bool {
        defaults.bool(forKey: Key.agreeWithTerms.rawValue)
    }

    public var id: String {
        defaults.string(forKey: Key.id.rawValue) ?? "DEBUG"
    }

    public var name: String? {
        defaults.string(forKey: Key.name.rawValue)
    }

    public var email: String? {
        defaults.string(forKey: Key.email.rawValue)
    }

    public var blockedIDs: [String] {
        defaults.stringArray(forKey: Key.blockedIDs.rawValue) ?? []
    }

    private init() { }

    public func save(user: User) {
        defaults.setValue(user.email, forKey: Key.email.rawValue)
        defaults.setValue(user.name, forKey: Key.name.rawValue)
        defaults.setValue(user.id, forKey: Key.id.rawValue)
        defaults.setValue(true, forKey: Key.isLoggedIn.rawValue)
    }

    public func set(value: Any, key: Key) {
        defaults.setValue(value, forKey: key.rawValue)
    }

    public func clear() {
        set(value: false, key: Key.isLoggedIn)
        set(value: false, key: Key.agreeWithTerms)
        defaults.setValue(nil, forKey: Key.id.rawValue)
        defaults.setValue(nil, forKey: Key.name.rawValue)
        defaults.setValue(nil, forKey: Key.email.rawValue)
        defaults.setValue(nil, forKey: Key.blockedIDs.rawValue)
    }
}

extension UserData {

    public enum Key: String {
        case isLoggedIn
        case email
        case name
        case id
        case agreeWithTerms
        case recordID
        case blockedIDs
    }

}
