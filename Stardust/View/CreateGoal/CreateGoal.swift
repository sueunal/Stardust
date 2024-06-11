//
//  CreateGoal.swift
//  Stardust
//
//  Created by sueun kim on 5/29/24.
//

import SwiftUI

struct CreateGoal: View {
    @State private var title: String = ""
    let gradient = LinearGradient(colors: [Color.black,Color.black,Color.black,Color.white],
                                  startPoint: .top, endPoint: .bottom)
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    Spacer()
                        .frame(height: 100)
                    titleMessage()
                    Spacer()
                    CustomTextField(text: $title, promptText: "목표 제목을 입력해주세요!")
                    Spacer()
                    nextButton()
                }
                .padding(.horizontal,16)
            }
            .navigationTitle("")
        }
    }
    @ViewBuilder
    func titleMessage()-> some View{
        HStack(spacing: 0){
            Text("오늘의 목표 제목을 입력해 주세요!")
                .font(AppFont.title1Bold)
                .foregroundStyle(.white)
            Spacer()
        }
    }
    @ViewBuilder
    func nextButton()-> some View{
        NavigationLink{
            GoalDetailView(title: $title)
        }label: {
            Text("다음으로")
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundStyle(.white)
                .font(AppFont.title3Bold)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.dark)
                )
        }
        .disabled(title.isEmpty)
        .padding(.vertical,16)
    }
}


#Preview {
    CreateGoal()
}
