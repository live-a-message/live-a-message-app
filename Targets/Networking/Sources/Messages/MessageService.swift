//
//  MessageService.swift
//  Networking
//
//  Created by Tales Conrado on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation

/// Protocol for messages CRUD
public protocol MessageService: AnyObject {
    /// Fetchs messages included in a given radius. A `radius` of `0` equals fetching all messages at once.
    /// - Parameters:
    ///     - location: the current location of the user
    ///     - radius: the search radius
    ///     - completion: the result of fetching messages
    func fetchMessages(location: Location, radius: Double, completion: @escaping ((Result<[Message], MessageServiceError>) -> Void))

    /// Adds a message to the given location.
    /// - Parameters:
    ///     - message: message to be saved
    ///     - completion: the result of saving a message
    func addMessage(message: Message, completion: @escaping ((Result<Bool, MessageServiceError>) -> Void))

    /// Removes a message from the database.
    /// - Parameters:
    ///     - message: message to be deleted
    ///     - completion: the result of deleting a message
    func deleteMessage(message: Message, completion: @escaping ((Result<Bool, MessageServiceError>) -> Void))

    /// Modify a message property
    /// - Parameters:
    ///     - id: id from the message to be modified
    ///     - completion: the result of modify a message
    func modifyMessage(message: Message, completion: ((Result<Bool, MessageServiceError>) -> Void)?)
}

public enum MessageServiceError: Error {
    /// Ocurred when a message could not be found in the database to delete it
    case messageNotFound
    /// Ocurred when parsing a message to save it
    case failedToEncode
    /// Ocurred when parsing a message to present and return it
    case failedToDecode
    /// Could not connect to the network
    case networkError
    /// Could not write to file
    case failedToWrite
    /// Could not read file
    case failedToRead
}
