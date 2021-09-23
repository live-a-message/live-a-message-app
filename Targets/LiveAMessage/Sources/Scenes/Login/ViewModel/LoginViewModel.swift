//
//  LoginViewModel.swift
//  Akee
//
//  Created by Vinicius Mesquita on 22/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import AuthenticationServices

protocol LoginViewModelProtocol {
    func authenticate()
}

protocol AutheticationService: NSObject {
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

class SignInWithAppleAuthorization: NSObject, AutheticationService {
    func authenticate() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension SignInWithAppleAuthorization: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?
            ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
        }
    }

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        print(error)
    }
}
