//
//  CustomButton.swift
//  Stardust
//
//  Created by sueun kim on 6/9/24.
//

import SwiftUI

struct CustomButton: View {
    let buttonText: String
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }){
            Text(buttonText)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundStyle(.white)
                .font(AppFont.title3Bold)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.dark)
                )
        }
        .padding(.vertical,16)
    }
}

#Preview {
    CustomButton(buttonText: "목표 생성하기"){
        
    }
}
