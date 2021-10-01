//
//  ReportViewModel.swift
//  Akee
//
//  Created by Tales Conrado on 30/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import Networking

class ReportViewModel {
    private let message: Message
    private let service: UserService

    init(message: Message, service: UserService) {
        self.message = message
        self.service = service
    }

    func reportUser(completion: @escaping ((Bool) -> Void)) {
        guard let reportedUserId = message.userId,
              let userId = UserData.shared.id else {
            print(UserServiceError.userNotFound)
            completion(false)
            return
        }

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
                completion(false)
            }
        }
    }

    func blockUser(completion: @escaping ((Bool) -> Void)) {
        guard let userId = message.userId else {
            print(UserServiceError.userNotFound)
            completion(false)
            return
        }

        service.block(userId: userId) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
