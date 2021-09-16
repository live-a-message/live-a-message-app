//
//  MapViewModel.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation
import Networking
import MapKit
import CoreLocation

class MapViewModel: NSObject, MapViewModelProtocol{
  
  typealias MessagesHandler = (Result<[Message], MessageServiceError>) -> Void
  var currentLocation = Location(lat: "0", lon: "0")
  let localService = LocalMessageService()
  var messages : [Message] = []
  var radius: Double = 300

  func getMessages() {
    localService.fetchMessages(location: currentLocation, radius: radius){ result in
      switch result{
      case .success(let messages):
        self.messages = messages
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  func didUpdatedLocation() {
    
  }
  
  func addMessage(message: Message) {
    localService.addMessage(message: message) { result in
      switch result {
      case .success(let result):
        print(result)
      case .failure(let error):
        print(error)
      }
    }
  }
}
