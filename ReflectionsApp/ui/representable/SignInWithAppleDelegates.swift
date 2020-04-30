//
//  SignInWithAppleDelegates.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 29/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import AuthenticationServices
class SignInWithAppleDelegates: NSObject, ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        <#code#>
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let idCreds = authorization.credential as? ASAuthorizationAppleIDCredential {
            if let email = idCreds.email, let name = idCreds.fullName {

                self.createAccount(email: email, name: name, id: idCreds.user)
            } else {
                login(idCreds)
            }
            
        } else if let passwd = authorization.credential as? ASPasswordCredential {
            
        }
    }
    
    func createAccount(email: String, name: PersonNameComponents, id: String) {
        let user = AppleUser(email: email, name: name, id: id)
        
        let keychain  = UserDataK
    }
}
