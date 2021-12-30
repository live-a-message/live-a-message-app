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
    private let zoneId = CKRecordZone.default().zoneID
    private lazy var database = container.publicCloudDatabase

    public init() {}

    public func fetch(identifier: String, completion: @escaping ((Result<User, UserServiceError>) -> Void)) {
        let predicate = NSPredicate(format: "id == %@", identifier)
        let query = CKQuery(recordType: CKRecordType.UsersInfo.rawValue, predicate: predicate)
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

    public func fetch(identifiers: [String], completion: @escaping ((Result<[User], UserServiceError>) -> Void)) {
        let predicates = NSPredicate(format: "id IN %@", identifiers)
        let query = CKQuery(recordType: CKRecordType.UsersInfo.rawValue, predicate: predicates)
        let operation = CKQueryOperation(query: query)
        var users = [User]()

        operation.recordFetchedBlock = { record in
            guard let user = try? CKUser(record).user else {
                completion(.failure(.failedToDecode))
                return
            }
            users.append(user)
        }

        operation.queryCompletionBlock = { _, error in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            completion(.success(users))
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
    // MARK: - Report

    public func report(report: Report, completion: @escaping ((Result<Bool, UserServiceError>) -> Void)) {
        let record = CKReport.encode(report)
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

    // MARK: - BlockedUsers

    public func block(userId: String, completion: @escaping ((Result<Bool, UserServiceError>) -> Void)) {
        fetchBlockedUsers { result in
            switch result {
            case .success(let record):
                guard var blockedUsers = try? CKBlockedUsers(record).users else {
                    completion(.failure(.failedToDecode))
                    return
                }
                blockedUsers.append(userId)
                record["users"] = blockedUsers
                UserData.shared.set(value: blockedUsers, key: .blockedIDs)
                self.updateBlockedUsers(record: record) { result in
                    switch result {
                    case .success:
                    completion(.success(true))
                    case .failure(let error):
                    completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func unblock(userId: String, completion: @escaping ((Result<Bool, UserServiceError>) -> Void)) {
        fetchBlockedUsers { result in
            switch result {
            case .success(let record):
                guard var blockedUsers = try? CKBlockedUsers(record).users else {
                    completion(.failure(.failedToDecode))
                    return
                }
                blockedUsers.removeAll(where: { $0 == userId })
                record["users"] = blockedUsers
                UserData.shared.set(value: blockedUsers, key: .blockedIDs)
                self.updateBlockedUsers(record: record) { result in
                    switch result {
                    case .success:
                    completion(.success(true))
                    case .failure(let error):
                    completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func fetchBlockedUsers(completion: @escaping ((Result<CKRecord, UserServiceError>) -> Void)) {
        let meId = UserData.shared.id
        let predicate = NSPredicate(format: "userId == %@", meId)
        let query = CKQuery(recordType: CKRecordType.BlockedUsers.rawValue, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        var isBlockedUsersEmpty = true

        operation.recordFetchedBlock = { record in
            isBlockedUsersEmpty = false
            completion(.success(record))
        }

        operation.queryCompletionBlock = { _, error in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            if isBlockedUsersEmpty {
                let record = CKBlockedUsers.encode(.init(userId: meId, users: []))
                completion(.success(record))
            }
        }

        operation.qualityOfService = .utility
        database.add(operation)
    }

    public func updateBlockedUsers(record: CKRecord, completion: @escaping ((Result<Bool, UserServiceError>) -> Void)) {
        let operation = CKModifyRecordsOperation()
        operation.recordsToSave = [record]
        operation.modifyRecordsCompletionBlock = { record, _, error in
            guard error == nil else {
                completion(.failure(.failedToRead))
                return
            }
            guard record != nil else {
                completion(.failure(.failedToRead))
                return
            }
            completion(.success(true))
        }

        operation.completionBlock = {
            completion(.success(true))
        }

        database.add(operation)
    }

    // MARK: - Terms

    public func fetchTerms(completion: @escaping ((Result<Terms, UserServiceError>) -> Void)) {
        let recordName = "Terms-" + Language.locale().rawValue
        database.fetch(withRecordID: CKRecord.ID(recordName: recordName)) { record, error in
            guard error == nil else {
                completion(.failure(.failedToRead))
                return
            }
            guard let record = record,
                  let terms = try? CKTerms(record).terms else {
                completion(.failure(.failedToRead))
                return
            }
            completion(.success(terms))
        }
    }
}
