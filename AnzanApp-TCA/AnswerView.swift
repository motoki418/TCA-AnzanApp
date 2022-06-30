//
//  AnswerView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/30.
//

import ComposableArchitecture
import SwiftUI

struct AnswerView: View {

    let store: Store<CounterState, CounterAction>

    let soundPlayer = SoundPlayer()

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack{
                Image.kokuban
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                VStack{
                    Text("\(viewStore.firstNumber) + \(viewStore.secondNumber) = \(viewStore.inputNumber)")

                    Text("答えは\(viewStore.firstNumber + viewStore.secondNumber)")

                    if viewStore.firstNumber + viewStore.secondNumber == viewStore.inputNumber {
                        Text(viewStore.state.correctAnswer)
                    } else {
                        Text(viewStore.state.incorrectAnswer)
                    }
                }
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .frame(width:300)
                .frame(height: 150)
            }
            .onAppear {
                //正解の場合
                if viewStore.state.firstNumber + viewStore.state.secondNumber == viewStore.state.inputNumber {

                    soundPlayer.correctSoundPlay()
                }
                //不正解の場合
                else{
                    soundPlayer.incorrectSoundPlay()
                }
            }
            .onDisappear {
                viewStore.send(.sheetDismissed)
            }
        }
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(
            store: Store(
                initialState: CounterState(),
                reducer: counterReducer,
                environment: CounterEnvironment()
            )
        )
    }
}
