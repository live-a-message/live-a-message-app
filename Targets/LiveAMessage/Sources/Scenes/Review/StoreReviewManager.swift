//
//  StoreReviewManager.swift
//  Akee
//
//  Created by Fernando de Lucas da Silva Gomes on 08/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

final class StoreReviewController {

    let defaults = UserDefaults.standard
    let infoDictionaryKey = kCFBundleVersionKey as String
    lazy var processCompletedCountKey = defaults.integer(forKey: UserDefaultsKeys.processCompletedCountKey.rawValue)
    lazy var lastVersionPromptedForReview = defaults.string(forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey.rawValue)

    lazy var currentBundleVersion: String = {
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
        else { fatalError("Expected to find a bundle version in the info dictionary") }
        return currentVersion
    }()

    func showReviewRequest(completion: @escaping () -> Void) {
        if !isReviewAllowed() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    SKStoreReviewController.requestReview()
                    UserDefaults.standard.set(self.currentBundleVersion, forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey.rawValue)
                    self.updateUserDefaults()
                    completion()
            }
        } else {
            completion()
        }
    }

    func updateUserDefaults() {
        defaults.set(processCompletedCountKey+1, forKey: UserDefaultsKeys.processCompletedCountKey.rawValue)
    }

    func isReviewAllowed() -> Bool {
        return processCompletedCountKey >= 4 && currentBundleVersion != lastVersionPromptedForReview
    }

    enum UserDefaultsKeys: String {
        case processCompletedCountKey, lastVersionPromptedForReviewKey
    }
}
