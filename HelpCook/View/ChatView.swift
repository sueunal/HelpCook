//
//  ChatView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//
import SwiftUI


struct ChatView: View {
    
    @State var inputMessage: String = ""
    let contentMessage: String = "hello my name is"
    var message: String =  ""
    var body: some View {
        VStack{
            HStack{
                senderView()
                if false{
                    senderView()
                }else{
                    Spacer()
                }
            }
                messageContentView(messageContent: inputMessage)
            HStack(alignment: .center){
                InputView(text: $inputMessage, placeholder: "메시지를 입력해주세요", title: "")
                sendButton()
                    .padding([.top,.trailing],10)
            }
        }
    }
    @ViewBuilder
    func sendButton() -> some View{
        Button{
            messageContentView(messageContent: message)
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
    }
}

#Preview {
    ChatView()
}
