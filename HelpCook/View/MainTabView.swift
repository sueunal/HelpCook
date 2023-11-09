//
//  ContentView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            VStack{
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    ChatView()
                        .tabItem {
                            Label("Chat", systemImage: "message")
                        }
                    ProfileView(pickedImage: Image(""), imageViewModel: ImageViewModel.init())
                        .tabItem {
                            Label("Profile", systemImage: "person.circle")
                        }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
