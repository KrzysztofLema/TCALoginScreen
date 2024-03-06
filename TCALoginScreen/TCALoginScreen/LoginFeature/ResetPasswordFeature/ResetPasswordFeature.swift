//
//  ResetPasswordFeature.swift
//  TCALoginScreen
//
//  Created by Krzysztof Lema on 06/03/2024.
//

import ComposableArchitecture
import SwiftUI

struct ResetPasswordFeature: Reducer {
    struct State: Equatable {
    }
    
    enum Action: Equatable {
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    Text("Przypomnij hasło")
                        .font(.title)
                        .bold()
                        
                        
                    Text("")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ResetPasswordFeatureView(store: Store(initialState: ResetPasswordFeature.State(), reducer: {
            ResetPasswordFeature()
        }))
    }
}
