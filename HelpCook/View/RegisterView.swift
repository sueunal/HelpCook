//
//  RegisterView.swift
//  HelpCook
//
//  Created by sueun kim on 11/19/23.
//

import SwiftUI

struct RegisterView: View {
    @State var emailAddress: String = ""
    @State var passwd: String = ""
    @ObservedObject var authViewModel = AuthViewModel()
    @State var isError: Bool = false
    @State var isRegistered: Bool = false
    @State var path = Path()
    var body: some View {
        NavigationStack{
            VStack(spacing: 20){
                Spacer()
                Text("Register")
                    .font(.title)
                    .fontWeight(.heavy)
                InputFieldView(inputString: $emailAddress, inputMessage: "이메일을 입력해주세요")
                SecureInputView(secureMessage: "비밀번호를 입력해주세요", password: $passwd)
                registerButton()
                Spacer()
            }.navigationDestination(isPresented: $isRegistered){
                loginView()
            }
        }
    }
    @ViewBuilder
    func registerButton()-> some View{
        Button{
            authViewModel.registerUser(email: emailAddress, password: passwd)
            if authViewModel.isRegistered{
                isRegistered.toggle()
            }else{
                isError.toggle()
            }
        }label: {
            Text("회원가입")
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .frame(maxWidth:.infinity,maxHeight: 20)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(.black)
                        .frame(maxWidth: 200)
                )
        }.alert(isPresented: $isError, content: {
            Alert(title: Text(authViewModel.errorMessage))
        })
    }
}

#Preview {
    RegisterView()
}
