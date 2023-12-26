//
//  ContentView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var viewModel = AuthViewModel()
    
    @State var showMainTabView: Bool = false
    @Binding var user : UserModel
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
                        ChatView(user: $user)
                            .tabItem {
                                Label("Chat", systemImage: "message")
                            }
                        ProfileView(user: $user)
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
    MainTabView(user: .constant(.dummy))
}
