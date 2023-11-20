//
//  AuthViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 11/19/23.
//

import Foundation
import FirebaseAuth


enum AuthError: Error{
    case short
    case notEmailFormatted
    case alreadyEmail
    case notProvided
   
    var errorMessage: String{
        switch self{
        case .alreadyEmail:
            return "이미 존재하는 이메일 입니다 다른 이메일 주소를 사용해주세요."
        case .short:
            return "패스워드가 너무 짧습니다 6글자 이상을 사용해주세요"
        case .notEmailFormatted:
            return "이메일 형식이 아닙니다."
        case .notProvided:
            return "이메일이 입력되지 않았습니다."
        }
    }
    
}
class AuthViewModel: ObservableObject {
    @Published var isLogin: Bool = false
    @Published var isRegistered: Bool = false
    @Published var errorMessage: String = ""
    
    init() {
        
    }
    func errorHandling(){
    }
    func registerUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error?.localizedDescription{
                switch error{
                case "The password must be 6 characters long or more.":
                    self.errorMessage = AuthError.short.errorMessage
                    self.isRegistered = false
                case "The email address is already in use by another account.":
                    self.errorMessage = AuthError.alreadyEmail.errorMessage
                    self.isRegistered = false
                case "The email address is badly formatted.":
                    self.errorMessage = AuthError.notEmailFormatted.errorMessage
                    self.isRegistered = false
                case "An email address must be provided.":
                    self.errorMessage = AuthError.notProvided.errorMessage
                    self.isRegistered = false
                default:
                    self.errorMessage = error
                    self.isRegistered = false
                }
            }
            guard let user = result?.user else { return }
            self.isRegistered = true
            print(user.uid)
        }
    }
    func login(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { results, error in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let user = results?.user{
                    self.isLogin = true
                    print("\(user) Login Success")
                }
            }
        }
    }
}
