//
//  AddMessageViewModel.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Networking
import CoreLocation
import Foundation
import DesignSystem

protocol AddMessageViewModelProtocol: AnyObject {
    var messageService: MessageService { get }
    var didSaveMessage: ((Message) -> Void)? { get set }
    func saveMessage(
        with content: String,
        image: Data?
    )
}

class AddMessageViewModel: AddMessageViewModelProtocol {
    var messageService: MessageService = CloudKitMessagesService()
    var currentLocation: CLLocation?
    var didSaveMessage: ((Message) -> Void)?

    func saveMessage(
        with content: String,
        image: Data?
    ) {
      guard let coordinate = self.currentLocation?.coordinate else { return }
        let message = Message(
            userId: UserData.shared.id,
            content: content,
            image: nil,
            location: Location(from: coordinate),
            imageAsset: image
        )

        messageService.addMessage(message: message) { result in
            switch result {
            case .success(_ ):
                self.didSaveMessage?(message)
            case .failure( let error):
                print(error)
            }
        }

    }

  init() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(setLocation(_:)),
      name: .updateLocation,
      object: nil
    )
  }

  @objc func setLocation(_ notification: Notification) {
    guard let location = notification.object as? CLLocation else {
      return
    }
    self.currentLocation = location
  }
}

extension Notification.Name {
  static let updateLocation = Notification.Name(rawValue: "updateLocation")
}
