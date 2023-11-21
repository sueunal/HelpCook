//
//  SecureInputView.swift
//  HelpCook
//
//  Created by sueun kim on 11/19/23.
//

import SwiftUI

struct SecureInputView: View {
    let secureMessage: LocalizedStringKey
    @Binding var password: String
    var body: some View {
        SecureField(secureMessage, text: $password)
            .padding()
            .frame(maxHeight: 50)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke()
                    .frame(maxHeight: 50)
            )
            .padding(10)
    }
}
