//
//  MultiplicationAnswerView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/07/11.
//


import ComposableArchitecture
import SwiftUI

struct MultiplicationAnswerView: View {
    
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
                    viewStore.send(.multiplication)
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
                HStack {
                    Text("\(viewStore.multiplicationFirstNumber)")
                    
                    Image(systemName: "multiply")
                    
                    Text("\(viewStore.multiplicationSecondNumber) = \(viewStore.inputNumber)")
                }
                Text("答えは \(viewStore.multiplicationFirstNumber * viewStore.multiplicationSecondNumber)")
                
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


//struct MultiplicationAnswerView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiplicationAnswerView(
//            store: Store(
//                initialState: CounterState(),
//                reducer: counterReducer,
//                environment: CounterEnvironment()
//            )
//        )
//    }
//}
