//
//  senderView.swift
//  HelpCook
//
//  Created by sueun kim on 12/18/23.
//

import SwiftUI

struct senderView: View {
    @ObservedObject var imageViewModel = ImageViewModel()
    var body: some View {
        VStack{
            if let profileImage = imageViewModel.profileImage {
                HStack(alignment: .bottom, spacing: 10){
                    profileImage
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
                    messageContentView(messageContent: "안녕하세요")
                }
                .padding()
            }
        }
    }
}

#Preview {
    senderView()
}
