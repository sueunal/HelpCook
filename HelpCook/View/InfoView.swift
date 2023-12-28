//
//  InfoView.swift
//  HelpCook
//
//  Created by sueun kim on 12/1/23.
//

import SwiftUI

struct InfoView: View {
    @StateObject var viewModel = UserViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(viewModel.items.description)
//            Text(viewModel.items.first)
//                .font(.title3)
//                .bold()
//            Divider().background(
//                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .leading, endPoint: .trailing)
//            )
//            Text(viewModel.job)
//                .bold()
//            Divider()
//                .background(
//                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .leading, endPoint: .trailing)
//                )
        }
    }
}

#Preview {
    InfoView()
}
