//
//  CKDatabaseProtocol.swift
//  AkeeTests
//
//  Created by Vinicius Mesquita on 04/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

public protocol CKDatabaseProtocol {
    func add(_ operation: CKDatabaseOperation)
    func delete(withRecordID recordID: CKRecord.ID, completionHandler: @escaping (CKRecord.ID?, Error?) -> Void)
    func fetch(withRecordID recordID: CKRecord.ID, completionHandler: @escaping (CKRecord?, Error?) -> Void)
    func perform(_ query: CKQuery, inZoneWith zoneID: CKRecordZone.ID?, completionHandler: @escaping ([CKRecord]?, Error?) -> Void)
    func save(_ record: CKRecord, completionHandler: @escaping (CKRecord?, Error?) -> Void)
}

public protocol CKContainerProtocol {
    static func `default`() -> CKContainer
    var publicDatabase: CKDatabaseProtocol { get }
}

extension CKContainer: CKContainerProtocol {
    public var publicDatabase: CKDatabaseProtocol {
        self.publicCloudDatabase
    }
}

extension CKDatabase: CKDatabaseProtocol { }
