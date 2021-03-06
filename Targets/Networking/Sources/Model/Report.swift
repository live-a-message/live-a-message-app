//
//  Report.swift
//  Networking
//
//  Created by Vinicius Mesquita on 01/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation

public struct Report: Reportable {
    var userId: String
    var reportedUserId: String
    var content: String

    public init(userId: String, reportedUserId: String, content: String) {
        self.userId = userId
        self.reportedUserId = reportedUserId
        self.content = content
    }
}
