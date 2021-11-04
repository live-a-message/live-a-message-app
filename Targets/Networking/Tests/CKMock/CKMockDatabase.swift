//
//  CKMockDatabase.swift
//  NetworkingTests
//
//  Created by Vinicius Mesquita on 04/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit
import Networking

class CKMockDatabase: CKDatabaseProtocol {

    var shouldThrowError: Bool
    
    private lazy var messages = generateMockMessages(count: 100)

    init(shouldThrowError: Bool = false) {
        self.shouldThrowError = shouldThrowError
    }

    func add(_ operation: CKDatabaseOperation) {

    }

    func delete(withRecordID recordID: CKRecord.ID, completionHandler: @escaping (CKRecord.ID?, Error?) -> Void) {
        if shouldThrowError {
            completionHandler(nil, CKError(.networkFailure))
            return
        }
        completionHandler(CKRecord.ID(recordName: "message"), nil)
    }

    func fetch(withRecordID recordID: CKRecord.ID, completionHandler: @escaping (CKRecord?, Error?) -> Void) {
    }

    func perform(_ query: CKQuery, inZoneWith zoneID: CKRecordZone.ID?, completionHandler: @escaping ([CKRecord]?, Error?) -> Void) {
    }

    func save(_ record: CKRecord, completionHandler: @escaping (CKRecord?, Error?) -> Void) {

    }
}

extension CKMockDatabase {
    
    func generateMockMessages(count: Int) -> [Message] {
        var messages = [Message]()
        for index in 0...count {
            messages.append(
                Message(
                    id: "\(index)",
                    userId: "",
                    content: "",
                    image: "",
                    location: .init(lat: 1.0, lon: 1.0),
                    imageAsset: nil,
                    status: .read
                )
            )
        }
        return messages
    }
}
