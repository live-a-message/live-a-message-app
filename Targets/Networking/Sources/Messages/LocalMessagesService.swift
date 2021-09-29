//
//  LocalMessageService.swift
//  Networking
//
//  Created by Tales Conrado on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//
import Foundation

public class LocalMessageService: MessageService {

    public init() {}

    // MARK: Public Interface
    public func fetchMessages(location: Location = Location(lat: 0, lon: 0), radius: Double = 0, completion: @escaping ((Result<[Message], MessageServiceError>) -> Void)) {
        guard let jsonData = try? Data(contentsOf: getFilePath()) else {
            completion(.success([]))
            return
        }

        guard let messageArray = try? JSONDecoder().decode([Message].self, from: jsonData) else {
            completion(.failure(.failedToDecode))
            return
        }

        completion(.success(messageArray))
    }

    public func addMessage(message: Message, completion: @escaping ((Result<Bool, MessageServiceError>) -> Void)) {
        if FileManager.default.fileExists(atPath: getFilePath().path) {
            fetchMessages { result in
                switch result {
                case .success(var messages):
                    messages.append(message)
                    self.writeMessageArrayToFile(messages, completion: completion)
                case .failure(_):
                    completion(.failure(.failedToRead))
                }
            }
        } else {
            writeMessageArrayToFile([message], completion: completion)
        }
    }

    public func deleteMessage(message: Message, completion: @escaping ((Result<Bool, MessageServiceError>) -> Void)) {
        fetchMessages { result in
            switch result {
            case .success(var messages):
                messages.removeAll(where: { $0.id == message.id })
                self.writeMessageArrayToFile(messages, completion: completion)
            case .failure(_):
                completion(.failure(.failedToRead))
            }
        }
    }

    // MARK: Helpers
    private func getFilePath() -> URL {
        getDocumentsDirectory().appendingPathComponent("localMessages.json")
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    private func writeMessageArrayToFile(_ messages: [Message], completion: ((Result<Bool, MessageServiceError>) -> Void)) {
        guard let json = try? JSONEncoder().encode(messages) else {
            completion(.failure(.failedToEncode))
            return
        }

        do {
            try json.write(to: getFilePath())
            completion(.success(true))
        } catch {
            completion(.failure(.failedToWrite))
        }
    }
}
