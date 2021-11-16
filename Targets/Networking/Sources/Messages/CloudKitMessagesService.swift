//
//  CloudKitMessagesService.swift
//  Networking
//
//  Created by Vinicius Mesquita on 28/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

public class CloudKitMessagesService: MessageService {

    private let container: CKContainerProtocol
    private let recordName = "Messages"
    private let zoneId = CKRecordZone.default().zoneID
    private let database: CKDatabaseProtocol

    public init(container: CKContainerProtocol = CKContainer.default()) {
        self.container = container
        self.database = container.publicDatabase
    }

    public func fetchMessages(location: Location, radius: Double, completion: @escaping ((Result<[Message], MessageServiceError>) -> Void)) {
        let currentLocation = CLLocation(latitude: location.lat, longitude: location.lon)
//        let predicate = NSPredicate(
//            format: "distanceToLocation:fromLocation:(location, %@) < %f",
//            currentLocation,
//            NSNumber(value: radius)
//        )
        let query = CKQuery(recordType: recordName, predicate: NSPredicate(value: true))
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
                completion(.failure(self.mapError(error)))
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
                completion(.failure(self.mapError(error)))
                return
            }
            guard recordId != nil else {
                completion(.failure(.failedToRead))
                return
            }
            completion(.success(true))
        }
    }

    public func modifyMessage(message: Message, completion: ((Result<Bool, MessageServiceError>) -> Void)?) {
        let record = CKMessage.encode(message)
        let operation = CKModifyRecordsOperation()
        operation.recordsToSave = [record]
        operation.savePolicy = .allKeys
        operation.modifyRecordsCompletionBlock = { record, _, error in
            guard error == nil else {
                completion?(.failure(.failedToRead))
                return
            }
            guard record != nil else {
                completion?(.failure(.failedToRead))
                return
            }
            completion?(.success(true))
        }

        operation.completionBlock = {
            completion?(.success(true))
        }

        database.add(operation)
    }

    private func mapError(_ error: Error?) -> MessageServiceError {
        guard let error = error as? CKError else {
            return .networkError
        }
        switch error.code {
        case .assetFileNotFound: return .messageNotFound
        default: return .networkError
        }
    }
}
