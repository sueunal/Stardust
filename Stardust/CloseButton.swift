//
//  CloseButton.swift
//  Stardust
//
//  Created by sueun kim on 5/31/24.
//

import SwiftUI

struct CloseButton: View {
    @Environment (\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            Button{
                dismiss()
            }label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 16,height: 16)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    CloseButton()
}
