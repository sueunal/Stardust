//
//  CreateGoal.swift
//  Stardust
//
//  Created by sueun kim on 5/29/24.
//

import SwiftUI

struct CreateGoal: View {
    @State private var title: String = ""
    @Environment (\.dismiss) var dismiss
    @FocusState var isFocused: Bool
    let gradient = LinearGradient(colors: [Color.black,Color.black,Color.black,Color.white],
                                  startPoint: .top, endPoint: .bottom)
    var body: some View {
        NavigationStack{
            ZStack{
                gradient.ignoresSafeArea()
                VStack{
                    Spacer()
                        .frame(height: 100)
                    HStack(spacing: 0){
                        Text("오늘의 목표 제목을 설정해 주세요!")
                            .font(AppFont.title1Bold)
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    Spacer()
                    TextField("",
                              text: $title,
                              prompt: Text("목표 제목을 입력해주세요!")
                        .font(AppFont.calloutBold)
                        .foregroundStyle(.gray)
                    )
                    .padding(10)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .fill(.white.gradient)
                    )
                    .focused($isFocused)
                    Spacer()
                    nextButton()
                }
                .padding(.horizontal,16)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                isFocused = true
            }
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
