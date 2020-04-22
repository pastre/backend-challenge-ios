//
//  ContentView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 20/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var username: String = ""
    
    @State private var isUsernameOk: Bool = true
    @State private var isEmailOk: Bool = true
    
    private var isFormOk: Bool {
        return self.username.count > 5 && self.password.count > 5 && self.email.count > 5 && self.password == self.confirmPassword
    }
    
    @State private var isCreatingAccount: Bool = true
    
    @State private var isLoading: Bool = true
    
    let lightGray = #colorLiteral(red: 0.9095294476, green: 0.9096819758, blue: 0.9095093608, alpha: 0.5617303671)
    
    var body: some View {
        GeometryReader { reader in

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
                
                Group {
                    VStack {
                        Text("Already have an account?")
                        Button(action: self.changeMode) {
                            Text("Sign in")
                        }
                    }
                }
                
            }
            .padding(.horizontal, 40)
            
        }
    }
    
    func onTextFieldCommited () {
//        print("Commited", self.)
//        self.isFormOk = !self.email.isEmpty && !self.username.isEmpty && !self.password.isEmpty
    }
    
    func createAccountIfPossible() {
        
    }
    
    func changeMode() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
