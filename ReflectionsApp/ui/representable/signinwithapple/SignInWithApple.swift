//
//  SignInWithApple.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 29/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI
import AuthenticationServices

final class SignInWithApple: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
    
    typealias UIViewType = ASAuthorizationAppleIDButton
    

}
