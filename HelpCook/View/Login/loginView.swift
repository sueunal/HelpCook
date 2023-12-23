//
//  lgoinView.swift
//  HelpCook
//
//  Created by sueun kim on 11/20/23.
//

import SwiftUI

struct loginView: View {
    @State var email: String = ""
    @State var passwd: String = ""
    @State var showMainTabView: Bool =  false
    @ObservedObject var authViewModel = AuthViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                
                Text("로그인")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                
                Spacer()
                
                InputView(text: $email, placeholder: "Enter Email@Email.com", title:"Email" )
                
                InputView(text: $passwd, placeholder: "Enter Password", title: "Password", isSecureField: true)
                
                loginButton()
                Spacer()
            }
            .navigationDestination(isPresented: $showMainTabView){
                SetUserInformation()
                    .environmentObject(authViewModel)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    @ViewBuilder
    func loginButton()-> some View{
        Button{
            authViewModel.login(email: email, password: passwd)
        }label: {
            Text("로그인")
                .frame(width: 200, height: 50)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(.black)
                )
        }
        .onChange(of: authViewModel.loginStatus){ _ in
            showMainTabView.toggle()
        }
    }
}

#Preview {
    loginView()
}
