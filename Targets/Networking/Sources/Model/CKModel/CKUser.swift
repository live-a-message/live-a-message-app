//
//  CKUser.swift
//  Networking
//
//  Created by Vinicius Mesquita on 29/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

public class CKUser {

    private(set) var name: String
    private(set) var id: String
    private(set) var email: String

    public init(_ record: CKRecord) throws {
        guard let name = record["name"] as? String,
              let email = record["email"] as? String,
              let id = record["id"] as? String
        else { throw CKError.init(.assetFileModified) }
        self.name = name
        self.id = id
        self.email = email
    }

    public static func encode(_ user: User) -> CKRecord {
        let record = CKRecord(recordType: CKRecordType.UsersInfo.rawValue, recordID: CKRecord.ID(recordName: user.id))
        record["name"] = user.name
        record["email"] = user.email
        record["id"] = user.id
        return record
    }

    var user: User { User(name: name, id: id, email: email) }
}
