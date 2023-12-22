//
//  InfoView.swift
//  HelpCook
//
//  Created by sueun kim on 12/1/23.
//

import SwiftUI

struct InfoView: View {
    @Binding var user: UserModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(user.name)
                .font(.title3)
                .bold()
            Divider().background(
                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .leading, endPoint: .trailing)
            )
            Text(user.job)
                .bold()
            Divider()
                .background(
                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .leading, endPoint: .trailing)
                )
            Text(user.favorite)
                .bold()
                .foregroundStyle(.cyan)
            Divider()
                .background(
                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .leading, endPoint: .trailing)
                )
        }
    }
}

#Preview {
    InfoView(user: .constant(.dummy))
}
