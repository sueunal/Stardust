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
    let message: String
    var body: some View {
        VStack{
            Text(title)
            Text(message)
            CheckBoxView( isCheck: $isCheck)
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
                    .stroke()
                    .frame(width: 30,height: 30)
                    .foregroundStyle(.black)
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
    CheckToDoView(title: "운동하기", message: "런닝 30분 뛰기")
}
