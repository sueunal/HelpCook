//
//  InputFieldView.swift
//  HelpCook
//
//  Created by sueun kim on 11/19/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let placeholder: String
    let title: String
    var isSecureField: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .fontWeight(.semibold)
                .font(.footnote)
                .padding(.leading,10)
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .font(.system(size:14))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .foregroundStyle(.black)
                    )
                    .padding()
            }else{
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .foregroundStyle(.black)
                    )
                    .padding()
            }
        }
    }
}
#Preview {
    InputView(text: .constant(""), placeholder: "EmailAddress", title: "EmailAddress", isSecureField: false)
}
