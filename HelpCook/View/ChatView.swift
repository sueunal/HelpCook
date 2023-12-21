//
//  ChatView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//
import SwiftUI
import Observation

@Observable
class Message{
    var name: String = ""
    var message: [String] = []
    
    init(){}
    func messageInput(_ userMessage: String){
        message.append(userMessage)
        print(message)
    }
}

struct ChatView: View {
    
    @State var inputMessage: String = ""
    @State var isEmty: Bool = false
    let contentMessage: String = "hello my name is"
    var message = Message()
    var body: some View {
        VStack{
            ScrollView{
                HStack{
                    senderView()
                    if false{
                        senderView()
                    }else{
                        Spacer()
                    }
                }
                HStack{
                    Spacer()
                    VStack{
                        ForEach(message.message,id:\.self){ message in
                            messageContentView(messageContent: message)
                        }
                        .padding()
                    }
                }
            }
                Spacer()
                messageInputView()
        }
    }
    @ViewBuilder
    func messageInputView()-> some View{
        HStack(alignment: .center){
            InputView(text: $inputMessage, placeholder: "메시지를 입력해주세요", title: "")
            if inputMessage.isEmpty{
                Button{
                    message.messageInput(inputMessage)
                }label: {
                    Image(systemName: "arrow.up")
                        .frame(width: 20,height: 25)
                        .foregroundStyle(.black)
                        .padding()
                        .background(
                            Circle()
                                .foregroundStyle(.gray)
                                .frame(width: 35,height: 35)
                        )
                }
                .disabled(inputMessage.isEmpty)
            }else{
                Button{
                    message.messageInput(inputMessage)
                }label: {
                    Image(systemName: "arrow.up")
                        .frame(width: 20,height: 25)
                        .foregroundStyle(.black)
                        .padding()
                        .background(
                            Circle()
                                .foregroundStyle(.yellow)
                                .frame(width: 35,height: 35)
                        )
                }
                .disabled(inputMessage.isEmpty)
                
            }
        }
    }
}

#Preview {
    ChatView()
}
