//
//  UserData.swift
//  Akee
//
//  Created by Vinicius Mesquita on 30/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation

public protocol UserDataDelegate: AnyObject {
    func didValuesUpdate()
}

public class UserData {

    public static let shared = UserData()
    private let defaults = UserDefaults.standard

    public weak var delegate: UserDataDelegate?

    public var allowAR: Bool {
        get {
            defaults.bool(forKey: Key.allowAR.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Key.allowAR.rawValue)
            delegate?.didValuesUpdate()
        }
    }
    public var isLoggedIn: Bool {
        get {
            defaults.bool(forKey: Key.isLoggedIn.rawValue)
        }
        set {
            set(value: newValue, key: .isLoggedIn)
            delegate?.didValuesUpdate()
        }
    }

    public var agreeWithTerms: Bool {
        defaults.bool(forKey: Key.agreeWithTerms.rawValue)
    }

    public var id: String {
        defaults.string(forKey: Key.id.rawValue) ?? "DEBUG"
    }

    public var name: String? {
        get {
            defaults.string(forKey: Key.name.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Key.name.rawValue)
            delegate?.didValuesUpdate()
        }
    }

    public var username: String? {
        defaults.string(forKey: Key.username.rawValue)
    }

    public var email: String? {
        defaults.string(forKey: Key.email.rawValue)
    }

    public var blockedIDs: [String] {
        get {
            defaults.stringArray(forKey: Key.blockedIDs.rawValue) ?? []
        }
        set {
            set(value: newValue, key: .blockedIDs)
        }
    }

    public var readMessages: [String] {
        get {
            defaults.stringArray(forKey: Key.readMessages.rawValue) ?? []
        }
        set {
            set(value: newValue, key: .readMessages)
        }
    }

    private init() { }

    public func save(user: User) {
        defaults.setValue(user.email, forKey: Key.email.rawValue)
        defaults.setValue(user.name, forKey: Key.name.rawValue)
        defaults.setValue(user.id, forKey: Key.id.rawValue)
        defaults.setValue(true, forKey: Key.isLoggedIn.rawValue)
        defaults.setValue(user.username, forKey: Key.username.rawValue)
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
        case readMessages
        case allowAR
        case username
    }

}
