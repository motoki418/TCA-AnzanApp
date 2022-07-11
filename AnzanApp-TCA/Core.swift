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
    var multiplicationFirstNumber = Int.random(in: 1...10)
    var multiplicationSecondNumber = Int.random(in: 1...10)
    var inputText = ""
    var inputNumber = 0
    var answerText = ""
    let soundPlayer = SoundPlayer()
}

enum CounterAction: Equatable {
    case onAppear
    case sheetDismissed
    case textChanged(String)
    case addition
    case subtraction
    case multiplication
}

struct CounterEnvironment {}

let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { state, action, _ in
    
    switch action {
    case let .textChanged(inputText):
        state.inputText = inputText
        state.inputNumber = Int(state.inputText) ?? 0
        return .none
        
    case .sheetDismissed:
        state.firstNumber = Int.random(in: 1...100)
        state.secondNumber = Int.random(in: 1...100)
        state.multiplicationFirstNumber = Int.random(in: 1...10)
        state.multiplicationSecondNumber = Int.random(in: 1...10)
        state.inputText = ""
        return .none
        
    case .onAppear:
        state.firstNumber = Int.random(in: 1...100)
        state.secondNumber = Int.random(in: 1...100)
        state.multiplicationFirstNumber = Int.random(in: 1...10)
        state.multiplicationSecondNumber = Int.random(in: 1...10)
        return .none
        
    case .addition:
        if state.firstNumber + state.secondNumber == state.inputNumber {
            state.soundPlayer.correctSoundPlay()
            state.answerText = "正解"
        } else {
            state.soundPlayer.incorrectSoundPlay()
            state.answerText = "不正解"
        }
        return .none
        
    case .subtraction:
        if state.firstNumber - state.secondNumber == state.inputNumber || state.secondNumber - state.firstNumber == state.inputNumber {
            state.soundPlayer.correctSoundPlay()
            state.answerText = "正解"
        } else {
            state.soundPlayer.incorrectSoundPlay()
            state.answerText = "不正解"
            
        }
        return .none
        
    case .multiplication:
        if state.multiplicationFirstNumber * state.multiplicationSecondNumber == state.inputNumber {
            state.soundPlayer.correctSoundPlay()
            state.answerText = "正解"
        } else {
            state.soundPlayer.incorrectSoundPlay()
            state.answerText = "不正解"
        }
        return .none
        
    }
}
    .debug()

