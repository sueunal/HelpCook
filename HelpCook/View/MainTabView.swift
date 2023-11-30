//
//  ContentView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var isLogged: Bool = true
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            if isLogged{
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
                }.navigationBarBackButtonHidden(true)
            }else{
                RegisterView()
            }
        }
    }
}

#Preview {
    MainTabView()
}
