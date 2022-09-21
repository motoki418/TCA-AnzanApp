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
            Form {
                contactDeveloperButton
                
                reviewTheAppButton
            }
            .navigationTitle("設定・アプリ情報")
        }
    }
    
    private var contactDeveloperButton: some View {
        Button {
            openURL(URL(string: "https://twitter.com/motoki0418")!)
        } label: {
            Label("開発者にお問い合わせ", systemImage: "paperplane.fill")
                .foregroundColor(.fontColor)
        }
    }
    
    private var reviewTheAppButton: some View {
        Button {
            openURL(URL(string: "https://apps.apple.com/jp/app/%E6%9A%97%E7%AE%97%E3%82%A2%E3%83%97%E3%83%AA/id1632869426")!)
        } label: {
            Label("アプリをレビューする", systemImage: "pencil.and.ellipsis.rectangle")
                .foregroundColor(.fontColor)
        }
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
