//
//  SignInWithAppleAuthorization.swift
//  Networking
//
//  Created by Vinicius Mesquita on 24/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import AuthenticationServices
import CloudKit

public class SignInWithAppleAuthorization: NSObject, AutheticationService {

    private let service: UserService

    public init(service: UserService = CloudKitUserService()) {
        self.service = service
    }

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
            if let name = appleIDCredential.fullName?.givenName,
               let email = appleIDCredential.email {
                save(user: User(name: name, id: identifier, email: email))
            } else {
               fetch(identifier: identifier)
            }
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }

    private func fetch(identifier: String) {
        service.fetch(identifier: identifier, completion: { result in
            switch result {
            case .success(let user):
                UserDefaults.standard.setValue(user.email, forKey: "email")
                UserDefaults.standard.setValue(user.name, forKey: "name")
                UserDefaults.standard.setValue(user.id, forKey: "userId")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    private func save(user: User) {
        service.save(user: user, completion: { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
