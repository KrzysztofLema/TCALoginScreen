//
//  LoginFeature.swift
//  TCALoginScreen
//
//  Created by Krzysztof Lema on 05/03/2024.
//

import ComposableArchitecture
import SwiftUI

struct LoginFeature: Reducer {
    struct State: Equatable {}
    
    enum Action: Equatable {}
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch state {
            default:
                .none
            }
        }
    }
}

struct LoginView: View {
    let store: StoreOf<LoginFeature>
    @State private var login: String = ""
    @State private var password: String = ""
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form{
                Section {
                    VStack(alignment: .leading){
                        Text("Hej!")
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                            .padding(.bottom, 10)
                        Text("Nice to meet you in Login Screen")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.caption)
                        TextField("", text: $login)
                        Spacer()
                        Text("Password")
                            .font(.caption)
                        TextField("", text: $password)
                    }
                    HStack {
                        Spacer()
                        Button("Reset Password") {
                            
                        }
                    }
                    HStack(alignment: .center) {
                        Spacer()
                        Button("Log in") {
                            
                        }
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .circular))
                      Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("This is your first time:")
                        Button("Create Account") {
                            
                        }
                        Spacer()
                    }
                    Divider()
                        .background(.black)
                        .padding()
                    HStack(content: {
                        Spacer()
                        Button(action: {}) {
                              Image(systemName: "magnifyingglass")
                            }
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                        
                        Button(action: {}) {
                              Image(systemName: "magnifyingglass")
                            }
                            .padding()
                            .background(.black)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                        Spacer()
                    })
                }
            }
        }
    }
}

#Preview {
    LoginView(store: Store(initialState: LoginFeature.State(), reducer: {
        LoginFeature()
    }))
}
