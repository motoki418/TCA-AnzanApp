//
//  AdditionAnswerView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/30.
//

import ComposableArchitecture
import SwiftUI

struct AdditionAnswerView: View {
    
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
                    viewStore.send(.addition)
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
                Text("\(viewStore.firstNumber) + \(viewStore.secondNumber) = \(viewStore.inputNumber)")
                
                Text("答えは\(viewStore.firstNumber + viewStore.secondNumber)")
                
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

//struct AdditionAnswerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdditionAnswerView(
//            store: Store(
//                initialState: CounterState(),
//                reducer: counterReducer,
//                environment: CounterEnvironment()
//            )
//        )
//    }
//}
