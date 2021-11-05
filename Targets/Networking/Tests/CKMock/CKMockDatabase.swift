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

    var records: [CKRecord] = [
        CKRecord(recordType: "type", recordID: CKRecord.ID(recordName: "231324325434132"))
    ]

    init() {}

    func add(_ operation: CKDatabaseOperation) { }

    func delete(withRecordID recordID: CKRecord.ID, completionHandler: @escaping (CKRecord.ID?, Error?) -> Void) {
        guard let recordToDelete = records.filter({ $0.recordID.recordName == recordID.recordName }).first else {
            completionHandler(nil, CKError(.assetFileNotFound))
            return
        }
        guard let index = records.firstIndex(of: recordToDelete) else {
            completionHandler(nil, CKError(.assetFileNotFound))
            return
        }
        records.remove(at: index)
        completionHandler(recordToDelete.recordID, nil)
    }

    func fetch(withRecordID recordID: CKRecord.ID, completionHandler: @escaping (CKRecord?, Error?) -> Void) {
        completionHandler(nil, CKError(.networkFailure))
    }

    func perform(_ query: CKQuery, inZoneWith zoneID: CKRecordZone.ID?, completionHandler: @escaping ([CKRecord]?, Error?) -> Void) {
        completionHandler(nil, CKError(.networkFailure))
    }

    func save(_ record: CKRecord, completionHandler: @escaping (CKRecord?, Error?) -> Void) {
        guard CKRecordType.allCases.map({ $0.rawValue }).contains(record.recordType) else {
            completionHandler(nil, CKError(.assetFileNotFound))
            return
        }
        records.append(record)
        completionHandler(record, nil)
    }
}
