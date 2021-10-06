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
    private lazy var database = container.publicCloudDatabase

    public init() {}

    public func fetchMessages(location: Location, radius: Double = .greatestFiniteMagnitude, completion: @escaping ((Result<[Message], MessageServiceError>) -> Void)) {
        let currentLocation = CLLocation(latitude: location.lat, longitude: location.lon)
        let predicate = NSPredicate(
            format: "distanceToLocation:fromLocation:(location, %@) < %f",
            currentLocation,
            NSNumber(value: radius)
        )
        let query = CKQuery(recordType: recordName, predicate: predicate)
        let sortDescription = CKLocationSortDescriptor(key: "location", relativeLocation: currentLocation)
        query.sortDescriptors = [sortDescription]

        let operation = CKQueryOperation(query: query)
        var messages = [Message]()

        operation.recordFetchedBlock = { record in
            guard let message = try? CKMessage(record).message else {
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
        let record = CKMessage.encode(message)
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
        let record = CKMessage.encode(message)
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
