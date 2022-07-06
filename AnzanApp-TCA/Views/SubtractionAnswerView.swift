//
//  AnswerView.swift
//  SubtractionAnswerView-TCA
//
//  Created by nakamura motoki on 2022/06/30.
//

import ComposableArchitecture
import SwiftUI

struct SubtractionAnswerView: View {
    
    let store: Store<CounterState, CounterAction>
    
    private let soundPlayer = SoundPlayer()
    
    @Binding var isShowSheet: Bool
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack {
                    ZStack{
                        Image.kokuban
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        VStack{
                            
                            Text("\(viewStore.firstNumber) - \(viewStore.secondNumber) = \(viewStore.inputNumber)")
                            
                            Text("答えは\(viewStore.firstNumber - viewStore.secondNumber)")
                            
                            if viewStore.firstNumber + viewStore.secondNumber == viewStore.inputNumber {
                                Text("正解")
                            } else {
                                Text("不正解")
                            }
                        }
                        .font(.largeTitle)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            isShowSheet.toggle()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
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
}

//struct SubtractionAnswerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubtractionAnswerView(
//            store: Store(
//                initialState: CounterState(),
//                reducer: counterReducer,
//                environment: CounterEnvironment()
//            )
//        )
//    }
//}
