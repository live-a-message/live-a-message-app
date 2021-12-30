//
//  CKBlockedUsers.swift
//  Networking
//
//  Created by Vinicius Mesquita on 01/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

protocol Blockable {
    var userId: String { get }
    var users: [String] { get }
}

public class CKBlockedUsers: Blockable {

    private(set) var userId: String
    public var users: [String]
    private(set) var recordID: CKRecord.ID

    public init(_ record: CKRecord) throws {
        guard let userId = record["userId"] as? String,
              let users = record["users"] as? [String]
        else { throw CKError.init(.assetFileModified) }
        self.userId = userId
        self.users = users
        self.recordID = record.recordID
    }

    public static func encode(_ blocked: BlockedUsers) -> CKRecord {
        let record = CKRecord(recordType: CKRecordType.BlockedUsers.rawValue)
        record["userId"] = blocked.userId
        record["users"] = blocked.users
        return record
    }

    public var blockedUsers: BlockedUsers {
        BlockedUsers(userId: userId, users: users)
    }
}
