//
//  CheckToDoView.swift
//  Stardust
//
//  Created by sueun kim on 6/5/24.
//

import SwiftUI

struct CheckToDoView: View {
    @State var isCheck: Bool = false
    let title: String
    let messages: [String]
    var body: some View {
        ZStack{
            BackgroundView()
            VStack{
                Spacer()
                Text(title)
                    .foregroundStyle(.white)
                    .font(AppFont.title1Bold)
                ForEach(messages,id: \.self){ message in
                    HStack{
                        Text(message)
                            .foregroundStyle(.white)
                            .frame(height: 50)
                        Spacer()
                        CheckBoxView( isCheck: $isCheck)
                    }
                    .frame(maxWidth: .infinity)
                }
                Spacer()
            }
            .padding(.horizontal,10)
        }
    }
}
struct CheckBoxView: View {
    @Binding var isCheck: Bool
    var body: some View {
        VStack{
            Button{
                isCheck.toggle()
            }label: {
                Rectangle()
                    .strokeBorder(lineWidth: 2)
                    .frame(width: 30,height: 30)
                    .foregroundStyle(.white)
                    .overlay{
                        Image(systemName: "checkmark")
                            .foregroundStyle(isCheck ? .black : .white)
                    }
                    .animation(.easeInOut(duration: 0.5), value: isCheck)
            }
        }
    }
}

#Preview {
    CheckToDoView(title: "운동하기", messages:["운동 30분 하기","달리기"])
}
