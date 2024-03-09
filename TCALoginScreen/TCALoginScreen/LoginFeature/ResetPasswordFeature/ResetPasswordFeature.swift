//
//  ResetPasswordFeature.swift
//  TCALoginScreen
//
//  Created by Krzysztof Lema on 06/03/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ResetPasswordFeature {
    
    @ObservableState
    struct State: Equatable {
        var secondsElapsed = 0
    }
    
    enum Action: Equatable {
        case resetPasswordButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            default:
                    .none
            }
        }
    }
}

struct ResetPasswordFeatureView: View {
    let store: StoreOf<ResetPasswordFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }, content: { _ in
            Section {
                Text("Przypomnij hasło")
                    .font(.title)
                    .bold()
                Text("")
            }
        })
    }
}

#Preview {
    NavigationStack {
        ResetPasswordFeatureView(store: Store(initialState: ResetPasswordFeature.State(), reducer: {
            ResetPasswordFeature()
        }))
    }
}
