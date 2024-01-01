//
//  messageContentView.swift
//  HelpCook
//
//  Created by sueun kim on 12/18/23.
//

import SwiftUI

struct messageContentView: View {
    var messageContent: String
    @State var isCurrentUser: Bool = false
    var body: some View {
        Text(messageContent)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color.black)
            .background(isCurrentUser ? Color.blue : Color(UIColor.systemGray6 ))
            .cornerRadius(10)
    }
}

#Preview {
    messageContentView(messageContent: "기본 메시지 입니다.")
}
