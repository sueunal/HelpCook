//
//  setttingsView.swift
//  HelpCook
//
//  Created by sueun kim on 12/22/23.
//

import SwiftUI

struct SettingsView: View {
    @State private var confirm: Bool = false
    var body: some View {
        VStack{
//            InputView(text: $user.name, placeholder: "변경하실 이름을 입력해주세요", title: "변경하실 이름을 입력해주세요", isSecureField: false)
            Button{
                confirm = false
            }label: {
                Text("확인")
                    .foregroundStyle(.white)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    SettingsView()
}
