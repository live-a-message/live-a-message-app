//
//  CloudKitMessagesService.swift
//  Networking
//
//  Created by Vinicius Mesquita on 28/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

public class CloudKitMessagesService: MessageService {

    private let container = CKContainer.default()
    private let recordName = "Messages"
    private let zoneId = CKRecordZone.default().zoneID
    private lazy var database = container.privateCloudDatabase

    public init() {}

    public func fetchMessages(location: Location = .init(lat: .zero, lon: .zero), radius: Double = .zero, completion: @escaping ((Result<[Message], MessageServiceError>) -> Void)) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: recordName, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        var messages = [Message]()

        operation.recordFetchedBlock = { record in
            guard let message = self.decode(record: record) else {
                completion(.failure(.failedToDecode))
                return
            }
            messages.append(message)
        }

        operation.queryCompletionBlock = { _, error in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            completion(.success(messages))
        }

        operation.qualityOfService = .utility
        database.add(operation)
    }

    public func addMessage(message: Message, completion: @escaping ((Result<Bool, MessageServiceError>) -> Void)) {
        let record = self.encode(message: message)
        database.save(record) { record, error in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            guard record != nil else {
                completion(.failure(.failedToRead))
                return
            }
            completion(.success(true))
        }
    }

    public func deleteMessage(message: Message, completion: @escaping ((Result<Bool, MessageServiceError>) -> Void)) {
        let record = encode(message: message)
        database.delete(withRecordID: record.recordID) { recordId, error in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            guard recordId != nil else {
                completion(.failure(.failedToRead))
                return
            }
            completion(.success(true))
        }
    }
}
