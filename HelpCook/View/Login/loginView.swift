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
    @State var isLogin: Bool = false
    @ObservedObject var authViewModel = AuthViewModel()
    var body: some View {
            VStack{
                Text("LOGIN")
                    .font(.system(size: 50))
                    .italic()
                InputFieldView(inputString: $email, inputMessage: "이메일을 입력해주세요")
                SecureInputView(secureMessage: "비밀번호를 입력해주세요", password: $passwd)
                loginButton()
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isLogin) {
                MainTabView()
            }
    }
    @ViewBuilder func loginButton()-> some View{
        Button{
            authViewModel.login(email: email, password: passwd)
            isLogin.toggle()
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
    }
}

#Preview {
    loginView()
}
