//
//  CKTerms.swift
//  Networking
//
//  Created by Vinicius Mesquita on 02/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import CloudKit

public class CKTerms {

    private(set) var title: String
    private(set) var content: String

    public init(_ record: CKRecord) throws {
        guard let title = record["title"] as? String,
              let content = record["content"] as? String
        else { throw CKError.init(.assetFileModified) }
        self.title = title
        self.content = content
    }

    var terms: Terms { Terms(title: title, content: content) }
}

public struct Terms {
    public let title: String
    public let content: String
}
