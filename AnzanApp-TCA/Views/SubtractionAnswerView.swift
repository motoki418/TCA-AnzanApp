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
                ZStack{
                    backgroundKokubanImage
                    
                    answerSheet
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        closeSheetButton
                    }
                }
                .onAppear {
                    viewStore.send(.subtraction)
                }
                .onDisappear {
                    viewStore.send(.sheetDismissed)
                }
            }
        }
    }
    
    private var backgroundKokubanImage : some View {
        Image.kokuban
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    private var answerSheet: some View {
        WithViewStore(self.store) { viewStore in
            VStack{
                if viewStore.firstNumber >= viewStore.secondNumber {
                    Text("\(viewStore.firstNumber) - \(viewStore.secondNumber) = \(viewStore.inputNumber)")
                } else if viewStore.firstNumber <= viewStore.secondNumber {
                    Text("\(viewStore.secondNumber) - \(viewStore.firstNumber) = \(viewStore.inputNumber)")
                }
                
                if viewStore.firstNumber >= viewStore.secondNumber {
                    Text("答えは\(viewStore.firstNumber - viewStore.secondNumber)")
                } else if viewStore.firstNumber <= viewStore.secondNumber {
                    Text("答えは\(viewStore.secondNumber - viewStore.firstNumber)")
                }
                
                Text("\(viewStore.answerText)")
            }
            .font(.largeTitle)
        }
    }
    
    private var closeSheetButton: some View {
        Button {
            isShowSheet.toggle()
        } label: {
            Text("閉じる")
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
