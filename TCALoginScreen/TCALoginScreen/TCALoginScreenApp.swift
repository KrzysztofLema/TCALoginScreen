//
//  TCALoginScreenApp.swift
//  TCALoginScreen
//
//  Created by Krzysztof Lema on 17/01/2024.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCALoginScreenApp: App {
    var body: some Scene {
        WindowGroup {
            AppLoginRootView(
                store: Store(
                    initialState: AppLoginFeature.State(
                        path: StackState([.resetPassword(ResetPasswordFeature.State())]),
                        login: LoginFeature.State()),
                    reducer: {
                        AppLoginFeature()
                            ._printChanges()
                    }
                )
            )
        }
    }
}
