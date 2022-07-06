//
//  AdditionView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/07/06.
//

import ComposableArchitecture
import SwiftUI

struct AdditionView: View {
    
    let store: Store<CounterState, CounterAction>
    
    private let soundPlayer = SoundPlayer()
    
    @State private var isShowAlert = false
    @State private var isShowSheet = false
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Image.kokuban
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                VStack {
                    HStack {
                        Text("\(viewStore.firstNumber) + \(viewStore.secondNumber) =")
                            .font(.largeTitle)
                        TextField(
                            "答えは？",
                            text: viewStore.binding(
                                get: \.inputText,
                                send: CounterAction.textChanged
                            )
                        )
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                        .font(.title2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }// HStack
                    .frame(width:300)
                    .frame(height: 60)
                    
                    Button {
                        if viewStore.inputText.isEmpty {
                            
                            self.isShowAlert.toggle()
                        } else {
                            soundPlayer.resultAnnouncementSoundPlay()
                            // 結果発表の音が鳴り終わってから答えを表示する。
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.isShowSheet.toggle()
                            }
                        }
                    } label: {
                        Text("答える")
                            .font(.title)
                            .frame(height: 60)
                    }// Button
                    .background(Color.backgroundColor)
                }// VStack
                .onAppear {
                    viewStore.send(.onAppear)
                }// onAppear
                .alert(isPresented: $isShowAlert) {
                    Alert(
                        title: Text("注意"),
                        message: Text("答えを入力してください"),
                        dismissButton: .default(Text("了解"))
                    )
                }
                .sheet(isPresented: $isShowSheet) {
                    AdditionAnswerView(
                        store: self.store,
                        isShowSheet: $isShowSheet)
                }
            }
        }
    }
}

struct AdditionView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionView(
            store: Store(
                initialState: CounterState(),
                reducer: counterReducer,
                environment: CounterEnvironment()
            )
        )
    }
}
