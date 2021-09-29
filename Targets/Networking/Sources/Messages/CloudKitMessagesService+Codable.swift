//
//  CloudKitMessagesService+Codable.swift
//  Networking
//
//  Created by Vinicius Mesquita on 29/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

extension CloudKitMessagesService {
    func decode(record: CKRecord) -> Message? {
        guard let content = record["content"] as? String,
              let id = record["id"] as? String,
              let userId = record["userId"] as? String,
              let clLocation = record["location"] as? CLLocation
        else { return nil }

        let image = record["image"] as? String
        let location = Location(from: clLocation.coordinate)

        let message = Message(
            id: id,
            userId: userId,
            content: content,
            image: image,
            location: location
        )

        return message
    }

    func encode(message: Message) -> CKRecord {
        let record = CKRecord(recordType: "Messages")
        record["content"] = message.content
        record["id"] = message.id
        record["userId"] = message.userId
        record["image"] = message.image
        record["location"] = CLLocation(latitude: message.location.lat, longitude: message.location.lon)
        return record
    }
}
