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
    @State var detailGoalList: [String] = []
    @State private var isAddAnimation: Bool = false
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
                    ForEach(detailGoalList, id:\.self){ item in
                       Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .foregroundStyle(.white.gradient)
                            .overlay{
                               Text(item)
                                    .font(.body)
                                    .foregroundStyle(.black.gradient)
                            }
                            .animation(.easeInOut(duration: 0.5),value: isAddAnimation)
                    }
                    TextField(
                        "",
                        text: $detailGoalText,
                        prompt:
                            Text("자세한 계획을 입력해주세요!")
                            .foregroundStyle(.white.opacity(0.8))
                    )
                    .padding(.horizontal,10)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .foregroundStyle(.white.gradient)
                    )
                    .focused($foucused)
                    .overlay{
                        HStack{
                            Spacer()
                            Button{
                                detailGoalList.append(detailGoalText)
                            }label: {
                                Text("등록")
                                    .frame(height: 30)
                                    .foregroundStyle(.black)
                                    .padding(.horizontal,10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundStyle(.white.gradient)
                                    )
                                    .padding(.horizontal,10)
                            }
                        }
                    }
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
                GoalResultView(title: $title, goalDetail: $detailGoalText)
                    .navigationBarBackButtonHidden(true)
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
            .padding(.vertical,16)
            .disabled(detailGoalText.isEmpty)
        }
    }
}

#Preview {
    GoalDetailView(title:.constant("운동하기"))
}
