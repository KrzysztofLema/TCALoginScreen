//
//  LoginFeature.swift
//  TCALoginScreen
//
//  Created by Krzysztof Lema on 05/03/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct LoginFeature {
    @ObservableState
    struct State: Equatable {
        var credentials: Credentials = Credentials()
    }
    
    enum Action: Equatable {
        case createAccountButtonTapped
        case loginButtonTapped
        case facebookLoginButtonTapped
        case appleLoginButtonTapped
        case resetPasswordButtonTapped
        case onLoginInputChange(String)
        case onPasswordInputChange(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .createAccountButtonTapped:
                print("create account button tapped")
                return .none
            case .loginButtonTapped:
                print("login button tapped")
                return .none
            case .facebookLoginButtonTapped:
                print("faceBook login Button tapped")
                return .none
            case .appleLoginButtonTapped:
                print("apple login button tapped")
                return .none
            case .resetPasswordButtonTapped:
                return .none
            case .onLoginInputChange:
                return .none
            case .onPasswordInputChange:
                return .none
            }
        }
    }
}

struct LoginView: View {
  @Bindable var store: StoreOf<LoginFeature>
    
    var body: some View {
            Form {
                Section {
                    VStack(alignment: .leading) {
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
                        TextField("", text: $store.credentials.login.sending(\.onLoginInputChange))
                        Spacer()
                        Text("Password")
                            .font(.caption)
                        TextField("", text: $store.credentials.password.sending(\.onPasswordInputChange))
                    }
                    HStack {
                        Spacer()
                        NavigationLink(state: AppLoginFeature.Path.State.resetPassword(ResetPasswordFeature.State())) {
                            Button("Reset Password") {
                                store.send(.resetPasswordButtonTapped)
                            }
                        }
                    }
                    HStack(alignment: .center) {
                        Spacer()
                        Button("Log in") {
                            store.send(.loginButtonTapped)
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
                            store.send(.createAccountButtonTapped)
                        }
                        Spacer()
                    }
                    Divider()
                        .background(.black)
                        .padding()
                    HStack(content: {
                        Spacer()
                        Button(action: {
                            store.send(.facebookLoginButtonTapped)
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(.circle)
                        .buttonStyle(.borderless)
                      
                        Button(action: {
                            store.send(.appleLoginButtonTapped)
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                        .padding()
                        .background(.black)
                        .foregroundColor(.white)
                        .clipShape(.circle)
                        .buttonStyle(.borderless)
                        Spacer()
                    })
                }
            }
        }
}

#Preview {
    LoginView(store: Store(initialState: LoginFeature.State(), reducer: {
        LoginFeature()
    }))
}
