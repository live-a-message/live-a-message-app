//
//  CKMessage.swift
//  Networking
//
//  Created by Vinicius Mesquita on 29/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

public class CKMessage {

    private(set) var id: String
    private(set) var userId: String
    private(set) var content: String
    private(set) var image: String?
    private(set) var location: CLLocation
    private(set) var status: String?
    private(set) var imageAsset: CKAsset?

    public init(_ record: CKRecord) throws {
        let image = record["image"] as? String
        let imageAsset = record["imageAsset"] as? CKAsset
        guard let content = record["content"] as? String,
              let id = record["id"] as? String,
              let userId = record["userId"] as? String,
              let clLocation = record["location"] as? CLLocation,
              let status = record["status"] as? String
        else { throw CKError.decodingError }

        self.content = content
        self.id = id
        self.location = clLocation
        self.userId = userId
        self.image = image
        self.status = status
        self.imageAsset = imageAsset
    }

    public static func encode(_ message: Message) -> CKRecord {
        let record = CKRecord(
            recordType: CKRecordType.Messages.rawValue,
            recordID: CKRecord.ID(recordName: message.id)
        )
        record["content"] = message.content
        record["id"] = message.id
        record["userId"] = message.userId
        record["image"] = message.image
        record["imageAsset"] = encodeImage(message.imageAsset)
        record["location"] = CLLocation(latitude: message.location.lat, longitude: message.location.lon)
        record["status"] = message.status.rawValue
        return record
    }

    var message: Message {
        var messageStatus: MessageStatus = .unread
        if let status = status {
            messageStatus = MessageStatus(rawValue: status) ?? .unread
        }
        let message = Message(
            id: id,
            userId: userId,
            content: content,
            image: image,
            location: .init(from: location.coordinate),
            imageAsset: CKMessage.decodeImage(imageAsset),
            status: messageStatus
        )
        return message
    }

    public static func encodeImage(_ data: Data?) -> CKAsset? {
        guard let unwrapppedData = data else {
            return nil
        }
        guard let folder = try? FileHelper.sharedHelper.saveFile(unwrapppedData, as: "imageTemp.png", in: .ephemeral) else {
            return nil
        }
        return CKAsset(fileURL: folder)
    }

    public static func decodeImage(_ asset: CKAsset?) -> Data? {
        guard let unwrapppedAsset = asset else {
            return nil
        }

        guard let folder = unwrapppedAsset.fileURL else {
            return nil
        }
        return try? Data(contentsOf: folder)
    }
}
