//
//  SettingView.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/07/11.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        NavigationView {
            List {
                Button {
                    openURL(URL(string: "https://twitter.com/motoki0418")!)
                }label: {
                    Text("開発者にお問い合わせ")
                }
                
                Button {
                    openURL(URL(string: "https://apps.apple.com/jp/app/%E6%9A%97%E7%AE%97%E3%82%A2%E3%83%97%E3%83%AA/id1632869426")!)
                }label: {
                    Text("アプリのレビュー")
                }
            }
            .navigationTitle("設定・アプリ情報")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
