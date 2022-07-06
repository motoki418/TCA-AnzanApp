//
//  Core.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/30.
//
import ComposableArchitecture
import SwiftUI

struct CounterState: Equatable{
    var firstNumber = Int.random(in: 1...1000)
    var secondNumber = Int.random(in: 1...1000)
    var inputText = ""
    var inputNumber = 0
}

enum CounterAction: Equatable {
    case onAppear
    case sheetDismissed
    case textChanged(String)
}

struct CounterEnvironment {}

let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { state, action, _ in
    
    switch action {
    case let .textChanged(inputText):
        state.inputText = inputText
        state.inputNumber = Int(state.inputText) ?? 0
        return .none
        
    case .sheetDismissed:
        state.firstNumber = Int.random(in: 1...1000)
        state.secondNumber = Int.random(in: 1...1000)
        state.inputText = ""
        return .none
        
    case .onAppear:
        state.firstNumber = Int.random(in: 1...1000)
        state.secondNumber = Int.random(in: 1...1000)
        return .none
    }
}
    .debug()
