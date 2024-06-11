//
//  ToDoItems.swift
//  Stardust
//
//  Created by sueun kim on 6/10/24.
//

import SwiftUI

struct ToDoItems: View {
    let title: String
    let messages: [String]
    let date: String
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                Text(title)
                    .font(AppFont.title1Bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ForEach(messages, id: \.self){ message in
                    Text(message)
                        .font(AppFont.bodyRegular)
                        .foregroundStyle(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Text(date)
                    .font(AppFont.calloutBold)
                    .foregroundStyle(.white.gradient)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom,10)
            }
            .padding(.horizontal,10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.opacity(0.3))
            )
        }
    }
}

#Preview {
    ToDoItems(title: "title", messages: [ "message1","message2"], date: "2024:13:23")
}
