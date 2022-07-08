//
//  SubtractionView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/07/06.
//

import ComposableArchitecture
import SwiftUI

struct SubtractionView: View {
    
    let store: Store<CounterState, CounterAction>
    
    private let soundPlayer = SoundPlayer()
    
    @State private var isShowAlert = false
    @State private var isShowSheet = false
    
    // 入力フォームのフォーカスの状態を管理する状態変数
    @FocusState private var focusedField: Bool
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                ZStack {
                    Image.kokuban
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    VStack {
                        HStack {
                            if viewStore.firstNumber >= viewStore.secondNumber {
                                Text("\(viewStore.firstNumber) - \(viewStore.secondNumber) =")
                                    .font(.largeTitle)
                            } else if viewStore.firstNumber <= viewStore.secondNumber {
                                Text("\(viewStore.secondNumber) - \(viewStore.firstNumber) =")
                                    .font(.largeTitle)
                            }
                            TextField(
                                "答えは？",
                                text: viewStore.binding(
                                    get: \.inputText,
                                    send: CounterAction.textChanged
                                )
                            )
                            // 引数には @FocusStateの値を渡す
                            .focused(self.$focusedField)
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
                        SubtractionAnswerView(
                            store: self.store,
                            isShowSheet: $isShowSheet)
                    }
                }// ZStack
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            
                            Spacer()
                            
                            Button {
                                // textFieldからフォーカスを外すので、focusedFieldの値をtrueからfalseに切り替える
                                self.focusedField.toggle()
                            } label: {
                                Text("キーボードを閉じる")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SubtractionView_Previews: PreviewProvider {
    static var previews: some View {
        SubtractionView(
            store: Store(
                initialState: CounterState(),
                reducer: counterReducer,
                environment: CounterEnvironment()
            )
        )
    }
}
