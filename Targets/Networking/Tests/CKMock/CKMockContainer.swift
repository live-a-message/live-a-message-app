//
//  CKMockContainer.swift
//  NetworkingTests
//
//  Created by Vinicius Mesquita on 04/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit
import Networking

class CKMockContainer: CKContainerProtocol {

    class func `default`() -> CKContainer {
        return CKContainer(identifier: "mock_identifier")
    }

    private let database = CKMockDatabase()
    var publicDatabase: CKDatabaseProtocol { database }
}
