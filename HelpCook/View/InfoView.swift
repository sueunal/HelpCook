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
            Text(viewModel.items.name)
                .fontWeight(.heavy)
                .font(.system(size: 24))
                .fontDesign(.serif)
            Divider()
            Text(viewModel.items.job)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .fontDesign(.serif)
            Divider()
            Text(viewModel.items.image)
                .font(.system(size: 24))
                .fontWeight(.bold)
            Divider()
        }
    }
}

#Preview {
    InfoView()
}
