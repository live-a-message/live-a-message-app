//
//  ReportViewModel.swift
//  Akee
//
//  Created by Tales Conrado on 30/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import Networking
import OSLog

class ReportViewModel {
    private let message: Message
    private let service: UserService

    init(message: Message, service: UserService) {
        self.message = message
        self.service = service
    }

    func reportUser(completion: @escaping ((Bool) -> Void)) {
        let reportedUserId = message.userId
        let userId = UserData.shared.id

        let report = Report(
            userId: userId,
            reportedUserId: reportedUserId,
            content: message.content
        )

        service.report(report: report) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print(error)
                os_log("Error: Report request failed")
                completion(false)
            }
        }
    }

    func blockUser(completion: @escaping ((Bool) -> Void)) {
        service.block(userId: message.userId) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print(error)
                os_log("Error: Block user report failed")
                completion(false)
            }
        }
    }
}
