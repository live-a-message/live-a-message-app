//
//  Message.swift
//  Networking
//
//  Created by Tales Conrado on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation

public struct Message: Codable, Equatable {
    public let userId: String
    public let location: Location
    public let id: String

    public var status: MessageStatus
    public var content: String
    public var image: String?
    public var imageAsset: Data?

    public init(
        id: String = UUID().uuidString,
        userId: String,
        content: String,
        image: String?,
        location: Location,
        imageAsset: Data?,
        status: MessageStatus = .unread
    ) {
        self.userId = userId
        self.content = content
        self.image = image
        self.location = location
        self.id = id
        self.status = status
        self.imageAsset = imageAsset
    }

    public static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
}
