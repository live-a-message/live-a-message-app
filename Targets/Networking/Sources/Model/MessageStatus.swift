//
//  MessageStatus.swift
//  Networking
//
//  Created by Tales Conrado on 14/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation

public enum MessageStatus: String, Codable {
    case read
    case unread

    public init(rawValue: String?) {
        guard let rawValue = rawValue else {
            self = .unread
            return
        }
        self = MessageStatus(rawValue: rawValue) ?? .unread
    }
}
