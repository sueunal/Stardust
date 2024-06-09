//
//  CustomTextField.swift
//  Stardust
//
//  Created by sueun kim on 6/8/24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    let promptText: String
    var body: some View {
        TextField("",
                  text: $text,
                  prompt: Text(promptText)
            .font(AppFont.calloutBold)
            .foregroundStyle(.white.opacity(0.8))
        )
        .padding(.horizontal,10)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .foregroundStyle(.white)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .foregroundStyle(.white.gradient)
        )
        .focused($isFocused)
        .onAppear{
            isFocused = true
        }
        .onDisappear{
            isFocused = false
        }
    }
}

#Preview {
    CustomTextField(text: .constant(""), promptText: "여기에 입력해주세요")
}
