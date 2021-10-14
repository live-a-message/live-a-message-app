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
    private(set) var image: CKAsset?
    private(set) var location: CLLocation
    private(set) var status: String?

    public init(_ record: CKRecord) throws {
        let image = record["image"] as? CKAsset
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
    }

    public static func encode(_ message: Message) -> CKRecord {
        let record = CKRecord(
            recordType: CKRecordType.Messages.rawValue,
            recordID: CKRecord.ID(recordName: message.id)
        )
        record["content"] = message.content
        record["id"] = message.id
        record["userId"] = message.userId
        record["image"] = encodeImage(message.image)
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
            image: try? Data(contentsOf: image?.fileURL!),
            location: .init(from: location.coordinate),
            status: messageStatus
        )
        return message
    }
  
    public static func encodeImage(_ data: Data?) -> CKAsset?{
      guard let unWrapppedData = data else {
        return nil
      }
      guard let folder = FileHelper.sharedHelper.saveFile(unWrapppedData, as: "imageTemp.png", in: .ephemeral) else {
        return nil
      }
      return CKAsset(fileURL: folder)
    }
}
