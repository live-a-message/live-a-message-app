//
//  CKBlockedUsers.swift
//  Networking
//
//  Created by Vinicius Mesquita on 01/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

protocol Blockable {
    var userId: String  { get }
    var users: [String] { get }
}

public class CKBlockedUsers: Blockable {

    private(set) var userId: String
    private(set) var users: [String]

    public init(_ record: CKRecord) throws {
        guard let userId = record["userId"] as? String,
              let users = record["users"] as? [String]
        else { throw CKError.decodingError }
        self.userId = userId
        self.users = users
    }

    public static func encode(_ report: BlockedUsers) -> CKRecord {
        let record = CKRecord(recordType: "BlockedUsers")
        record["userId"] = report.userId
        record["users"] = report.users
        return record
    }

    public var blockedUsers: BlockedUsers {
        BlockedUsers(userId: userId, users: users)
    }
}
