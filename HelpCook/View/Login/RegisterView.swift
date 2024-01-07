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
    @Binding var isClick: Bool
    var body: some View {
        NavigationStack{
            VStack(spacing:1){
                Spacer()
                Text("회원가입")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                Spacer().frame(height: 100)
                InputView(text: $emailAddress, placeholder:"Enter Email@address.com" , title: "Email")
                InputView(text: $passwd, placeholder: "Enter Password", title: "Password", isSecureField: true)
                registerButton()
                    .alert(isPresented: $isError, content: {
                        Alert(title:Text("Error") ,
                              message: Text(authViewModel.errorMessage))
                    })
                Spacer()
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $isRegistered){
                loginView()
                    .navigationBarBackButtonHidden(true)
            }
            .toolbar{
                ToolbarItem {
                    Button{
                        isClick.toggle()
                    }label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .foregroundStyle(.black)
                            .padding()
                    }
                }
            }
        }
    }
    @ViewBuilder
    func registerButton()-> some View{
        Button{
            authViewModel.registerUser(email: emailAddress, password: passwd)
            if authViewModel.isRegistered{
                isRegistered = true
            }else{
                isError = true
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
        }
    }
}

#Preview {
    RegisterView( isClick: .constant(false))
}
