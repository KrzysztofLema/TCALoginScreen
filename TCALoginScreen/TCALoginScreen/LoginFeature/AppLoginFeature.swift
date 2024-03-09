//
//  AppLoginFeature.swift
//  TCALoginScreen
//
//  Created by Krzysztof Lema on 07/03/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AppLoginFeature {
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        var login = LoginFeature.State()
    }
    
    enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case login(LoginFeature.Action)
    }
    
    @Reducer
    struct Path {
        
        @ObservableState
        enum State {
            case resetPassword(ResetPasswordFeature.State)
        }
        
        enum Action {
            case resetPassword(ResetPasswordFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.resetPassword, action: \.resetPassword) {
                ResetPasswordFeature()
            }
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .login:
                return .none
            case .path(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
}

struct AppLoginRootView: View {
    @Bindable var store: StoreOf<AppLoginFeature>
    
    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            LoginView(store: store.scope(state: \.login, action: \.login))
        } destination: { store in
            switch store.state {
            case .resetPassword:
                if let store = store.scope(state: \.resetPassword, action: \.resetPassword) {
                    ResetPasswordFeatureView(store: store)
                }
            }
        }
    }
}

#Preview {
    AppLoginRootView(store: Store(initialState: AppLoginFeature.State(login: LoginFeature.State()) , reducer: {
        AppLoginFeature()
            ._printChanges()
    }))
}

