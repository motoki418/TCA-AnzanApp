//
//  AnswerView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/30.
//

import ComposableArchitecture
import SwiftUI

struct AnswerView: View {

    let store: Store<CounterState, CoutnerAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack{
                //黒板の画像を背景画像として表示する。
                Image("bunbougu_kokuban")
                //画像をリサイズする。
                    .resizable()
                //アスペクト比(縦横比)を保ったまま画面いっぱいに表示する。
                    .aspectRatio(contentMode: .fit)
                //計算式・答え・正解、不正解を縦方向にレイアウトする
                VStack{
                    // 計算式と答えをTextの文字列連結で一行で記述。
                    Text("\(viewStore.firstNumber) + \(viewStore.secondNumber) = \(viewStore.inputNumber)")
                    Text("答えは\(viewStore.firstNumber + viewStore.secondNumber)")
                    if viewStore.firstNumber + viewStore.secondNumber == viewStore.inputNumber {
                        Text(viewStore.state.correctAnswer)
                    } else {
                        Text(viewStore.state.incorrectAnswer)
                    }
                }// VStackここまで
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .frame(width:300)
                .frame(height: 150)
            }// ZStack
            .onAppear {
                //正解の場合
                if viewStore.state.firstNumber + viewStore.state.secondNumber == viewStore.state.inputNumber {
                    //正解の音を鳴らす。
                }
                //不正解の場合
                else{
                    //不正解の音を鳴らす。
                }
            }// onAppear
            .onDisappear {
                viewStore.send(.sheetDismissed)
            }// onDisappear
        }// WithViewStore
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
