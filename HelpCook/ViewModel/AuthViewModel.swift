//
//  AuthViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 11/19/23.
//

import Foundation
import FirebaseAuth
import Firebase


enum AuthState{
    case Success
    case Fail
}

enum AuthError: String, Error{
    case short = "패스워드가 너무 짧습니다 6글자 이상을 사용해주세요"
    case notEmailFormatted = "이메일 형식이 아닙니다."
    case alreadyEmail =  "이미 존재하는 이메일 입니다 다른 이메일 주소를 사용해주세요."
    case notProvided = "이메일이 입력되지 않았습니다."
    case invalidIdOrPw = "아이디 또는 비밀번호가 틀립니다."
}

class AuthViewModel: ObservableObject {
    @Published var loginStatus: Bool = false
    @Published var isRegistered: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoggin: Bool = false
    @Published var userSession: FirebaseAuth.User?
    let db = Firestore.firestore()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
       
    func saveUserInformation(nickName: String) {
        let collectionPath = Firestore.firestore().collection("users")
        let userID = Auth.auth().currentUser?.uid
        
        collectionPath.document("\(userID ?? "")").updateData(["nickname": nickName]) { error in
            if let error = error {
                print((error.localizedDescription))
                return
            }
        }
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        changeRequest?.displayName = nickName
        changeRequest?.commitChanges() { error in
            if let error = error {
                print("[ERROR] : photoURL 변경 중 에러 발생 \(error.localizedDescription)")
            }
            else {
                print("[DEBUG] : dispalyName 변경 성공")
                
            }
        }
        Auth.auth().currentUser?.reload()
    }
    func getUserInfo(){
//        Auth.auth().getStoredUser(forAccessGroup: "")
    }
    func registerUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error?.localizedDescription{
                switch error{
                case  AuthError.notProvided.rawValue:
                    self.errorMessage = AuthError.short.rawValue
                    self.isRegistered = false
                case AuthError.alreadyEmail.rawValue:
                    self.errorMessage = AuthError.alreadyEmail.rawValue
                    self.isRegistered = false
                case AuthError.notEmailFormatted.rawValue:
                    self.errorMessage = AuthError.notEmailFormatted.rawValue
                    self.isRegistered = false
                case AuthError.notProvided.rawValue:
                    self.errorMessage = AuthError.notProvided.rawValue
                    self.isRegistered = false
                case  AuthError.notProvided.rawValue:
                    self.errorMessage = AuthError.notProvided.rawValue
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
                case  AuthError.notProvided.rawValue:
                    self.errorMessage = AuthError.short.rawValue
                    self.isRegistered = false
                case AuthError.alreadyEmail.rawValue:
                    self.errorMessage = AuthError.alreadyEmail.rawValue
                    self.isRegistered = false
                case AuthError.notProvided.rawValue:
                    self.errorMessage = AuthError.notEmailFormatted.rawValue
                    self.isRegistered = false
                case AuthError.notProvided.rawValue:
                    self.errorMessage = AuthError.notProvided.rawValue
                    self.isRegistered = false
                case AuthError.notProvided.rawValue:
                    self.errorMessage = AuthError.notProvided.rawValue
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
