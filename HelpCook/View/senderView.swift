//
//  senderView.swift
//  HelpCook
//
//  Created by sueun kim on 12/18/23.
//

import SwiftUI

struct senderView: View {
    @ObservedObject var imageViewmodel = ImageViewModel()
    var body: some View {
        HStack(alignment: .bottom, spacing: 10){
            imageViewmodel.profileImage
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            
            messageContentView(messageContent: "안녕하세요")
        }.onAppear{
            imageViewmodel.imageDonwload()
        }
        .padding()
    }
}

#Preview {
    senderView()
}
