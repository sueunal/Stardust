//
//  GoalDetailView.swift
//  Stardust
//
//  Created by sueun kim on 5/31/24.
//

import SwiftUI

struct GoalDetailView: View {
    let gradiant = AngularGradient(colors: [.background,.white], center: .top)
    @Binding var title: String
    @State var detailGoalText: String = ""
    @FocusState var foucused
    @State private var createGoal: Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                gradiant.ignoresSafeArea()
                VStack{
                    Spacer()
                        .frame(height: 32)
                    HStack{
                        Text("\(title) 목표의 세부 계획을 작성해주세요!")
                            .font(AppFont.title1Bold)
                            .foregroundStyle(.text)
                        Spacer()
                    }
                    Spacer()
                    TextEditor(text: $detailGoalText)
                        .frame(height: 200)
                        .scrollContentBackground(.hidden)
                        .background(
                            AngularGradient(colors: [.dark,.white], center: .bottomTrailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .focused($foucused)
                    Spacer()
                    createStar()
                }
                .padding(.horizontal,16)
            }
            .toolbar{
                ToolbarItem (placement: .topBarTrailing){
                   CloseButton()
                }
            }
            .navigationDestination(isPresented: $createGoal){
                
            }
        }
    }
    @ViewBuilder
    func createStar()-> some View{
        VStack{
            Button{
                createGoal.toggle()
            }label: {
               Text("목표 생성하기")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundStyle(.white)
                    .font(AppFont.title3Bold)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.dark)
                    )
            }
            .disabled(detailGoalText.isEmpty)
        }
    }
}

#Preview {
    GoalDetailView(title:.constant("운동하기"))
}
