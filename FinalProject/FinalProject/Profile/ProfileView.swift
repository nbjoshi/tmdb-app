//
//  ProfileView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/23/25.
//

import Security
import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileVM: ProfileViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        if let profile = profileVM.profile {
            VStack(spacing: 20) {
                Text("Welcome, \(profile.name)!")
                    .font(.title)
                    .bold()

                Button("Log Out") {
                    Task {
                        if profileVM.session != nil {
                            username = ""
                            password = ""
                            await profileVM.logout()
                        }
                    }
                }
                .foregroundStyle(.red)
                .padding()
            }
            .padding()
        } else {
            Form {
                Section(header: Text("TMDB Login")) {
                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                }
                Button("Log In") {
                    Task {
                        await profileVM.createRequestToken()
                        
                        if let token = profileVM.token {
                            await profileVM.validateRequestToken(username: username, password: password, requestToken: token)
                        }

                        if let validatedToken = profileVM.validatedToken {
                            await profileVM.createSession(requestToken: validatedToken)
                        }

                        if let sessionId = profileVM.session {
                            await profileVM.getProfile(sessionId: sessionId)
                        }
                        
                        if let sessionId = profileVM.session, profileVM.profile != nil {
                            profileVM.saveSession(username: username, sessionId: sessionId)
                            username = ""
                            password = ""
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    ProfileView()
//}
