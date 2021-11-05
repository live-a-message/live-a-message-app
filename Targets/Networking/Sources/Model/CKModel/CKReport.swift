//
//  CKReport.swift
//  Networking
//
//  Created by Vinicius Mesquita on 01/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

protocol Reportable {
    var userId: String { get }
    var content: String { get }
    var reportedUserId: String { get }
}

public class CKReport: Reportable {

    private(set) var userId: String
    private(set) var content: String
    private(set) var reportedUserId: String

    public init(_ record: CKRecord) throws {
        guard let content = record["content"] as? String,
              let userId = record["userId"] as? String,
              let reportedUserId = record["reportedUserId"] as? String
        else { throw CKError.init(.assetFileModified) }
        self.userId = content
        self.content = userId
        self.reportedUserId = reportedUserId
    }

    public static func encode(_ report: Report) -> CKRecord {
        let record = CKRecord(recordType: CKRecordType.Report.rawValue)
        record["content"] = report.content
        record["userId"] = report.userId
        record["reportedUserId"] = report.reportedUserId
        return record
    }

    public var report: Report {
        Report(
            userId: userId,
            reportedUserId: reportedUserId,
            content: content
        )
    }
}
