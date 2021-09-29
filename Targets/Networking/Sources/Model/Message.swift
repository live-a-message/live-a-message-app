//
//  Message.swift
//  Networking
//
//  Created by Tales Conrado on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation

public struct Message: Codable, Equatable {
    public let userId: String?
    public let location: Location
    public let id: String

    public var status: MessageStatus
    public var content: String
    public var image: String?

    public init(id: String = UUID().uuidString, userId: String?, content: String, image: String?, location: Location) {
        self.userId = userId
        self.content = content
        self.image = image
        self.location = location
        self.id = id
        self.status = .unread
    }

    public static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
}
