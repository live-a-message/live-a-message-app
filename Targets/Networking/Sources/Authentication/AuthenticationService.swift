//
//  AuthenticationService.swift
//  Networking
//
//  Created by Tales Conrado on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import Foundation

public protocol AutheticationService: NSObject {
    var delegate: SignInWithAppleAuthorizationDelegate? { get set }
    func authenticate()
}
