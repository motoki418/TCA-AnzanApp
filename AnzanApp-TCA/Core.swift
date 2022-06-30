//
//  Core.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/30.
//
import ComposableArchitecture
import SwiftUI

struct CounterState: Equatable{
    var alert: AlertState<CounterState>?// OptionalState
    var firstNumber = 0
    var secondNumber = 0
    var inputText = ""
    var inputNumber = 0
    var correctAnswer = "正解"
    var incorrectAnswer = "不正解"
}

enum CounterAction: Equatable {
    case onAppear
    case alertDismissed
    case sheetDismissed
    case textChanged(String)
    case AnswerButtonTapped
}

struct CounterEnvironment {}

let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment
    > { state, action, _ in

    switch action {
    case .AnswerButtonTapped:

        return .none

    case let .textChanged(inputText):
        state.inputText = inputText
        state.inputNumber = Int(state.inputText) ?? 0
        return .none

    case .alertDismissed:
        state.firstNumber = Int.random(in: 1...1000)
        state.secondNumber = Int.random(in: 1...1000)
        state.inputText = ""
        state.alert = nil
        return .none

    case .sheetDismissed:
        state.firstNumber = Int.random(in: 1...1000)
        state.secondNumber = Int.random(in: 1...1000)
        state.inputText = ""
        return .none

    case .onAppear:
        state.firstNumber = Int.random(in: 1...100)
        state.secondNumber = Int.random(in: 1...100)
        return .none
    }
}
    .debug()
