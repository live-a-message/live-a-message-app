//
//  UserService.swift
//  Akee
//
//  Created by Vinicius Mesquita on 29/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation

public protocol UserService: AnyObject {
    /// Fetchs user included in a given  identifier.
    /// - Parameters:
    ///     - identifier: the id of the user
    ///     - completion: the result of fetching user
    func fetch(identifier: String, completion: @escaping ((Result<User, UserServiceError>) -> Void))
    /// Fetchs user included in a given  identifier.
    /// - Parameters:
    ///     - identifier: the id of the user
    ///     - completion: the result of fetching user
    func fetch(identifiers: [String], completion: @escaping ((Result<[User], UserServiceError>) -> Void))
    /// Save user to user defaults when starts log-in
    /// - Parameters:
    ///     - user: the following user to be saved
    ///     - completion: the result of saving user
    func save(user: User, completion: @escaping ((Result<Bool, UserServiceError>) -> Void))
    /// Save user to user defaults when starts log-in
    /// - Parameters:
    ///     - userId: the following user to be reported
    ///     - completion: the result of saving user
    func report(report: Report, completion: @escaping ((Result<Bool, UserServiceError>) -> Void))
    /// Save user to user defaults when starts log-in
    /// - Parameters:
    ///     - userId: the following user to be blocked
    ///     - completion: the result of saving user
    func block(userId: String, completion: @escaping ((Result<Bool, UserServiceError>) -> Void))
    /// Get the terms of user.
    /// - Parameters:
    ///     - completion: the result of saving user
    func fetchTerms(completion: @escaping ((Result<Terms, UserServiceError>) -> Void))
}

public enum UserServiceError: Error {
    /// Ocurred when a user  could not be found in the database to delete it
    case userNotFound
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
