//
//  AnonymousUserView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 21/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import AuthenticationServices
import SwiftUI

struct AnonymousUserView: View {

    @Environment(\.window) var window: UIWindow?
    @State var appleSignInDelegates: SignInWithAppleDelegates! = nil
    
    @State private var email: String = "pastrebru@gmail.com"
    @State private var password: String = "asdqwe123"
    @State private var confirmPassword: String = ""
    @State private var username: String = "pastrebru"
    
    
    @ObservedObject var model: AnonymousUserObservableObject// = AnonymousUserObservableObject()
    
    @State private var isCreatingAccount: Bool = true
    
    @State private var isAuthenticated: Bool = false
    
    @State private var toggleMe: Bool = false
    
    let lightGray = #colorLiteral(red: 0.9095294476, green: 0.9096819758, blue: 0.9095093608, alpha: 0.5617303671)
    
    private var isFormOk: Bool {
        return self.isCreatingAccount ? self.username.count > 5 && self.password.count > 5 && self.email.count > 5 :  self.email.count > 5 && self.password.count > 5
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack  {
                if self.isCreatingAccount {
                    VStack(alignment: .center) {
                        
                        TextField("Username", text: self.$username)
                        .padding()
                            .textFieldStyle(DefaultTextFieldStyle())
                        .background(Color(self.lightGray))
                        .cornerRadius(5)
                        .padding(.bottom, 5)
                        
                        TextField("Email", text: self.$email)
                        .padding()
                        .background(Color(self.lightGray))
                        .cornerRadius(5)
                        .padding(.bottom, 20)
                        
                        SecureField("Password", text: self.$password)
                            .padding()
                            .background(Color(self.lightGray))
                            .cornerRadius(5)
                            .padding(.bottom, 5)
            
                        SecureField("Confirm your password", text: self.$confirmPassword)
                            .padding()
                            .background(Color(self.lightGray))
                            .cornerRadius(5)
                            .padding(.bottom, 40)
                            
                        Button(action: self.createAccountIfPossible) {
                            Text("Create account").fontWeight(.light)
                        }
                            .font(.title)
                            .padding(.bottom, 60)
                            .disabled(!self.isFormOk)
                        
                    }
                .padding(.horizontal, 40)
                }
                else {
                    VStack {
                        
                        TextField("Username", text: self.$username)
                        .padding()
                        .background(Color(self.lightGray))
                        .cornerRadius(5)
                        .padding(.bottom, 10)
                        
                        SecureField("Password", text: self.$password)
                            .padding()
                            .background(Color(self.lightGray))
                            .cornerRadius(5)
                            .padding(.bottom, 20)
                        
                        Button(action: self.loginIfPossible) {
                            Text("Login").fontWeight(.light)
                        }
                            .font(.title)
                            .padding(.bottom, 60)
                            .disabled(!self.isFormOk)
                    }
                    .padding(.horizontal, 40)
                }

                Group {
                    VStack {
                        
                        Text(self.isCreatingAccount ? "Already have an account?" : "Don't have an account?")
                        Button(action: {
                            self.isCreatingAccount.toggle()
                        }) {
                            Text(self.isCreatingAccount ? "Sign in" : "Create account")
                        }.padding(.bottom, 40)

                        SignInWithApple()
                            .frame(width: 280, height: 60)
                            .onTapGesture {
                                self.showAppleLogin()
                            }
                    }
                }
                
            }
        }
    }
    
    func createAccountIfPossible() {
        self.model.createAccount(self.username, email: self.email, password: self.password)
    }
    
    func loginIfPossible() {
        self.model.login(self.username, self.password)
    }
    
    private func showAppleLogin() {
       let request = ASAuthorizationAppleIDProvider().createRequest()
       request.requestedScopes = [.fullName, .email]
        
        self.model.startApple2fa()
       performSignIn(using: [request])
     }

     /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
     private func performExistingAccountSetupFlows() {
       #if !targetEnvironment(simulator)
       // Note that this won't do anything in the simulator.  You need to
       // be on a real device or you'll just get a failure from the call.
       let requests = [
         ASAuthorizationAppleIDProvider().createRequest(),
         ASAuthorizationPasswordProvider().createRequest()
       ]

       performSignIn(using: requests)
       #endif
     }

     private func performSignIn(using requests: [ASAuthorizationRequest]) {
       appleSignInDelegates = SignInWithAppleDelegates(window: window) { success in
         if success {
            self.model.resolveAuthentication()
         } else {
           // show the user an error
         }
       }

       let controller = ASAuthorizationController(authorizationRequests: requests)
       controller.delegate = appleSignInDelegates
       controller.presentationContextProvider = appleSignInDelegates

       controller.performRequests()
     }
}

struct AnonymousUserView_Previews: PreviewProvider {
    static var previews: some View {
        AnonymousUserView(model: AnonymousUserObservableObject())
    }
}

