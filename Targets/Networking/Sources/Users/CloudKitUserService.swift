//
//  CloudKitUserService.swift
//  Akee
//
//  Created by Vinicius Mesquita on 29/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

public class CloudKitUserService: UserService {

    private let container = CKContainer.default()
    private let recordName = "Users"
    private let zoneId = CKRecordZone.default().zoneID
    private lazy var database = container.publicCloudDatabase

    public init() {}

    public func fetch(identifier: String, completion: @escaping ((Result<User, UserServiceError>) -> Void)) {
        let predicate = NSPredicate(format: "id == %@", identifier)
        let query = CKQuery(recordType: recordName, predicate: predicate)
        let operation = CKQueryOperation(query: query)

        operation.recordFetchedBlock = { record in
            guard let user = try? CKUser(record).user else {
                completion(.failure(.failedToDecode))
                return
            }
            completion(.success(user))
        }

        operation.queryCompletionBlock = { _, error in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
        }

        operation.qualityOfService = .utility
        database.add(operation)
    }

    public func save(user: User, completion: @escaping ((Result<Bool, UserServiceError>) -> Void)) {
        let record = CKUser.encode(user)
        database.save(record) { record, error in
            guard error == nil else {
                completion(.failure(.failedToRead))
                return
            }
            guard record != nil else {
                completion(.failure(.failedToRead))
                return
            }
        }
        completion(.success(true))
    }

}