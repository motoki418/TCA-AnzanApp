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
    
    let soundPlayer = SoundPlayer()
    
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
                            HStack {
                                Text("\(viewStore.multiplicationFirstNumber)")
                                
                                Image(systemName: "multiply")
                                
                                Text("\(viewStore.multiplicationSecondNumber) =")
                                
                                Text("\(viewStore.inputNumber)")
                            }
                            .font(.largeTitle)
                            
                            Text("答えは\(viewStore.multiplicationFirstNumber * viewStore.multiplicationSecondNumber)")
                            
                            Text("\(viewStore.answerText)")
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
                    viewStore.send(.multiplication)
                }
                .onDisappear {
                    viewStore.send(.sheetDismissed)
                }
            }
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
