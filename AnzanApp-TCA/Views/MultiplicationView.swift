//
//  MultiplicationView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/07/11.
//

//
//  AdditionView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/07/06.
//

import ComposableArchitecture
import SwiftUI

struct MultiplicationView: View {
    
    let store: Store<CounterState, CounterAction>
    
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
                            Text("\(viewStore.multiplicationFirstNumber)")
                                .font(.largeTitle)
                            Image(systemName: "multiply")
                                .font(.largeTitle)
                            Text("\(viewStore.multiplicationSecondNumber) =")
                                .font(.largeTitle)
                            TextField(
                                "答えは？",
                                text: viewStore.binding(
                                    get: \.inputText,
                                    send: CounterAction.textChanged
                                )
                            )
                            .frame(width: 120)
                            .font(.title2)
                            // 引数には @FocusStateの値を渡す
                            .focused(self.$focusedField)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .frame(width:350)
                        .frame(height: 60)
                        
                        Button {
                            if viewStore.inputText.isEmpty {
                                self.isShowAlert.toggle()
                            } else {
                                self.isShowSheet.toggle()
                            }
                        } label: {
                            Text("答える")
                                .font(.title)
                                .frame(width: 100, height: 60)
                        }
                        .background(Color.backgroundColor)
                    }
                    .onAppear {
                        viewStore.send(.onAppear)
                    }
                    .alert(isPresented: $isShowAlert) {
                        Alert(
                            title: Text("注意"),
                            message: Text("答えを入力してください"),
                            dismissButton: .default(Text("了解"))
                        )
                    }
                    .sheet(isPresented: $isShowSheet) {
                        MultiplicationAnswerView(
                            store: self.store,
                            isShowSheet: $isShowSheet)
                    }
                }
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

struct MultiplicationView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplicationView(
            store: Store(
                initialState: CounterState(),
                reducer: counterReducer,
                environment: CounterEnvironment()
            )
        )
    }
}
