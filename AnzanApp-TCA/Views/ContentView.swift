//
//  ContentView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/30.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    
    let store: Store<CounterState, CounterAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            TabView {
                AdditionView(store: self.store)
                    .tabItem {
                        Label("足し算", systemImage: "plus.circle")
                    }
                
                SubtractionView(store: self.store)
                    .tabItem {
                        Label("引き算", systemImage: "minus.circle")
                    }
                
                MultiplicationView(store: self.store)
                    .tabItem {
                        Label("掛け算", systemImage: "multiply.circle.fill")
                    }
                
                SettingView()
                    .tabItem {
                        Label("設定", systemImage: "gearshape.fill")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: CounterState(),
                reducer: counterReducer,
                environment: CounterEnvironment()
            )
        )
    }
}
