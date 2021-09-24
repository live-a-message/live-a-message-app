//
//  SignInWithAppleAuthorization.swift
//  Networking
//
//  Created by Vinicius Mesquita on 24/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import AuthenticationServices

public class SignInWithAppleAuthorization: NSObject, AutheticationService {
    public func authenticate() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension SignInWithAppleAuthorization: ASAuthorizationControllerDelegate {

    public func authorizationController(controller: ASAuthorizationController,
                                        didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?
            ASAuthorizationAppleIDCredential {
            let identifier = appleIDCredential.user
            let name = appleIDCredential.fullName?.givenName
            let email = appleIDCredential.email
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(name, forKey: "firstName")
            UserDefaults.standard.set(identifier, forKey: "identifier")
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
