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

protocol AddMessageViewModelProtocol: AnyObject {
    var messageService: MessageService { get }
    func saveMessage(
        with content: String,
        image: String?
    )
}

class AddMessageViewModel: AddMessageViewModelProtocol {
    var messageService: MessageService = LocalMessageService()
    var currentLocation: CLLocation?

    func saveMessage(
        with content: String,
        image: String?
    ) {
      guard let coordinate = self.currentLocation?.coordinate else { return }
        let message = Message(
            userId: "",
            content: content,
            image: image,
          location: Location(from: coordinate)
        )

        messageService.addMessage(message: message) { _ in }
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
  static let updateLocation = Notification.Name(rawValue: "presentGame")
}
