//
//  SignInWithAppleAuthorization.swift
//  Networking
//
//  Created by Vinicius Mesquita on 24/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import AuthenticationServices
import CloudKit

public protocol SignInWithAppleAuthorizationDelegate: AnyObject {
    func didFinishFetching()
    func didFinishWithError(_ error: Error)
}

public class SignInWithAppleAuthorization: NSObject, AutheticationService {

    private let service: UserService
    weak public var delegate: SignInWithAppleAuthorizationDelegate?

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
            if let name = appleIDCredential.fullName?.givenName {
                let email = appleIDCredential.email
                save(user: User(name: name, id: identifier, email: email ?? ""))
            } else {
                fetch(identifier: identifier)
            }
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.delegate?.didFinishWithError(error)
    }

    private func fetch(identifier: String) {
        service.fetch(identifier: identifier, completion: { result in
            switch result {
            case .success(let user):
                UserData.shared.save(user: user)
                self.delegate?.didFinishFetching()
            case .failure(let error):
                self.delegate?.didFinishWithError(error)
            }
        })
    }

    private func save(user: User) {
        service.save(user: user, completion: { result in
            switch result {
            case .success(_):
                UserData.shared.save(user: user)
                self.delegate?.didFinishFetching()
            case .failure(let error):
                self.delegate?.didFinishWithError(error)
            }
        })
    }
}
