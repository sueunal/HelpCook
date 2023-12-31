//
//  ContentView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI

struct MainTabView: View {
    @State var showMainTabView: Bool = false
    var body: some View {
        NavigationStack(root: {
            ZStack{
                Color.black.ignoresSafeArea()
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
                        ProfileView()
                            .tabItem {
                                Label("Profile", systemImage: "person.circle")
                            }
                    }
                }
            }
        })
    }
}
#Preview {
    MainTabView()
}
