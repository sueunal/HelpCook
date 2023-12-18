//
//  senderView.swift
//  HelpCook
//
//  Created by sueun kim on 12/18/23.
//

import SwiftUI

struct senderView: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 10){
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            
            messageContentView(messageContent: "안녕하세요")
        }.padding()
    }
}

#Preview {
    senderView()
}
