//
//  Home.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
           Image(systemName: "house")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    HomeView()
}
