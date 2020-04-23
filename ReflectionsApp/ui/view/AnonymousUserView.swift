//
//  AnonymousUserView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 21/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SwiftUI

struct AnonymousUserView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var username: String = ""
    
    
    @ObservedObject var model: AnonymousUserObservableObject// = AnonymousUserObservableObject()
    
    @State private var isCreatingAccount: Bool = true
    
    @State private var isAuthenticated: Bool = false
    
    @State private var toggleMe: Bool = false
    
    let lightGray = #colorLiteral(red: 0.9095294476, green: 0.9096819758, blue: 0.9095093608, alpha: 0.5617303671)
    
    private var isFormOk: Bool {
        return self.username.count > 5 && self.password.count > 5 && self.email.count > 5 //&& self.password == self.confirmPassword
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
                } else {
                    VStack {
                        Text("faz login ae")
                    }
                }

                Group {
                    VStack {
                        
                        Text("Already have an account?")
                        Button(action: {
                            self.isCreatingAccount.toggle()
                        }) {
                            Text("Sign in")
                        }
                        
                    }
                }
                
            }
        }
    }
    
    func createAccountIfPossible() {
        self.model.createAccount(self.username, email: self.email, password: self.password)
    }
}

struct AnonymousUserView_Previews: PreviewProvider {
    static var previews: some View {
        AnonymousUserView(model: AnonymousUserObservableObject())
    }
}

