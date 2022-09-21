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
    
    @State private var isShowAlert = false
    
    @State private var isShowSheet = false
    
    // 入力フォームのフォーカスの状態を管理する状態変数
    @FocusState private var isActive: Bool
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                ZStack {
                    
                    backgroundKokubanImage
                    
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
                            .frame(width: 120)
                            .font(.title2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            // 引数には @FocusStateの値を渡す
                            .focused($isActive)
                        }
                        .frame(width: 350)
                        .frame(height: 60)
                        
                        answerButton
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
                        SubtractionAnswerView(
                            store: self.store,
                            isShowSheet: $isShowSheet)
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        closeTheKeyboardButton
                    }
                }
            }
        }
    }
    
    private var backgroundKokubanImage : some View {
        Image.kokuban
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    private var answerButton: some View {
        WithViewStore(self.store) { viewStore in
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
    }
    
    private var closeTheKeyboardButton: some View {
        Button {
            isActive.toggle()
        } label: {
            Text("キーボードを閉じる")
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
