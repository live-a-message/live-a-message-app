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
        guard let name = record["content"] as? String,
              let email = record["id"] as? String,
              let id = record["userId"] as? String
        else { throw CKError.decodingError }
        self.name = name
        self.id = id
        self.email = email
    }

    public static func encode(_ user: User) -> CKRecord {
        let record = CKRecord(recordType: "Users", recordID: CKRecord.ID(recordName: user.id))
        record["name"] = user.name
        record["email"] = user.email
        record["id"] = user.id
        return record
    }

    var user: User { User(name: name, id: id, email: email) }
}
