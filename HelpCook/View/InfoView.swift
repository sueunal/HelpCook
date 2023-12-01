//
//  InfoView.swift
//  HelpCook
//
//  Created by sueun kim on 12/1/23.
//

import SwiftUI

struct InfoView: View {
    @State private var name: String = "수은"
    @State private var jobs: String = "iOS Developer"
    @State private var favorite: String = "#ios #frontEnd #web #server"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(name)
                .font(.title3)
                .bold()
            Divider().background(
                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .leading, endPoint: .trailing)
            )
            Text(jobs)
                .bold()
            Divider()
                .background(
                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .leading, endPoint: .trailing)
                )
            Text(favorite)
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
    InfoView()
}
