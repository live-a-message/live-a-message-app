//
//  LoginViewModel.swift
//  Akee
//
//  Created by Vinicius Mesquita on 22/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Networking

protocol LoginViewModelProtocol {
    func authenticate()
}

class LoginViewModel: LoginViewModelProtocol {

    private let service: AutheticationService

    init(service: AutheticationService = SignInWithAppleAuthorization()) {
        self.service = service
    }

    func authenticate() {
        service.authenticate()
    }
}
