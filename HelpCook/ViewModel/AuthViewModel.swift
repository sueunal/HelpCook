//
//  AuthViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 11/19/23.
//

import Foundation
import FirebaseAuth


enum AuthState{
    case Success
    case Fail
}

enum AuthError: Error{
    case short
    case notEmailFormatted
    case alreadyEmail
    case notProvided
    case invalidIdOrPw
   
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
        case .invalidIdOrPw:
            return "아이디 또는 비밀번호가 틀립니다."
        }
    }
}
class AuthViewModel: ObservableObject {
    @Published var loginStatus: Bool = false
    @Published var isRegistered: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoggin: Bool = false
    @Published var userSession: FirebaseAuth.User?

    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    func getUserInfo(){
//        Auth.auth().getStoredUser(forAccessGroup: "")
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
                case "The password is invalid or the user does not have a password.":
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
    // MARK: - 로그인 기능
    func login(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { results, error in
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
                case "The password is invalid or the user does not have a password.":
                    self.errorMessage = AuthError.notProvided.errorMessage
                    self.isRegistered = false
                default:
                    self.errorMessage = error
                    self.isRegistered = false
                }
            }else{
                guard let user = results?.user else { return }
                print("\(user) Login Success")
                self.loginStatus = true
                DispatchQueue.main.async {
                    self.loginStatus = true
                }
            }
        }
    }
}
