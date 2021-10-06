//
//  Language.swift
//  Networking
//
//  Created by Vinicius Mesquita on 05/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation

/// Enumerate all languages from the app.
enum Language: String {
    case pt
    case en
    case znh

    /// Get a locale language if the langugage is not avaiable, the default would be english.
    /// - Returns: One available languange based on preferredLanguage
    static func locale() -> Language {
        let preferredLanguage = Locale.preferredLanguages.first as String?
        let rawValue = preferredLanguage?.components(separatedBy: "-").first ?? Language.en.rawValue
        return Language(rawValue: rawValue) ?? .en
    }
}
