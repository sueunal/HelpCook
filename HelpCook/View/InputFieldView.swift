//
//  InputFieldView.swift
//  HelpCook
//
//  Created by sueun kim on 11/19/23.
//

import SwiftUI

struct InputFieldView: View {
    @Binding var inputString: String
    let inputMessage: LocalizedStringKey
    
    var body: some View {
        TextField(inputMessage, text: $inputString)
            .padding()
            .frame(maxHeight: 50)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke()
                    .frame(maxHeight: 50)
            )
            .padding(10)
            .onAppear{
                print(inputString)
            }
    }
}
