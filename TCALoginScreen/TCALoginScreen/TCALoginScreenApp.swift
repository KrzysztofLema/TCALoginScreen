//
//  TCALoginScreenApp.swift
//  TCALoginScreen
//
//  Created by Krzysztof Lema on 17/01/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCALoginScreenApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(store: Store(initialState: LoginFeature.State(), reducer: {
                LoginFeature()
            }))
        }
    }
}
