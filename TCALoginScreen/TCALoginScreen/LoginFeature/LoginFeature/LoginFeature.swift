//
//  LoginFeature.swift
//  TCALoginScreen
//
//  Created by Krzysztof Lema on 05/03/2024.
//

import ComposableArchitecture
import SwiftUI

struct LoginFeature: Reducer {
    struct State: Equatable {
        @PresentationState var resetPassword: ResetPasswordFeature.State?
        @BindingState var credentials: Credentials
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case createAccountButtonTapped
        case loginButtonTapped
        case facebookLoginButtonTapped
        case appleLoginButtonTapped
        case resetPasswordButtonTapped
        case resetPassword(PresentationAction<ResetPasswordFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
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
                state.resetPassword = ResetPasswordFeature.State()
                return .none
            case .resetPassword:
                return .none
            }
        }
        .ifLet(\.$resetPassword, action: /Action.resetPassword) {
            ResetPasswordFeature()
        }
    }
}

struct LoginView: View {
    let store: StoreOf<LoginFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }, content: { viewStore in
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
                        TextField("", text: viewStore.$credentials.login)
                        Spacer()
                        Text("Password")
                            .font(.caption)
                        TextField("", text: viewStore.$credentials.password)
                    }
                    HStack {
                        Spacer()
                        Button("Reset Password") {
                            viewStore.send(.resetPasswordButtonTapped)
                        }.sheet(store: self.store.scope(state: \.$resetPassword, action: {.resetPassword($0)})) { store in
                            ResetPasswordFeatureView(store: store)
                        }
                    }
                    HStack(alignment: .center) {
                        Spacer()
                        Button("Log in") {
                            viewStore.send(.loginButtonTapped)
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
                            viewStore.send(.createAccountButtonTapped)
                        }
                        Spacer()
                    }
                    Divider()
                        .background(.black)
                        .padding()
                    HStack(content: {
                        Spacer()
                        Button(action: {
                            viewStore.send(.facebookLoginButtonTapped)
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(.circle)
                        .buttonStyle(.borderless)
                      
                        Button(action: {
                            viewStore.send(.appleLoginButtonTapped)
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
        })
    }
}

#Preview {
    LoginView(store: Store(initialState: LoginFeature.State(credentials: Credentials()), reducer: {
        LoginFeature()
    }))
}
