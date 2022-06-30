//
//  AnzanApp_TCAApp.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/30.
//

import ComposableArchitecture
import SwiftUI

@main
struct AnzanApp_TCAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: CounterState(),
                    reducer: counterReducer,
                    environment: CounterEnvironment()
                )
            )
        }
    }
}
