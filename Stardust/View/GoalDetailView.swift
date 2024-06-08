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
    @State private var isEmpty: Bool = true
    @State private var createGoal: Bool = false
    @State private var isShow: Bool = false
    @FocusState var foucused
    var body: some View {
        NavigationStack{
            ZStack{
                gradiant.ignoresSafeArea()
                VStack{
                    Spacer()
                        .frame(height: 32)
                    HStack{
                        Text("\(title) 목표의 자세한 계획을 추가해주세요")
                            .font(AppFont.title1Bold)
                            .foregroundStyle(.text)
                        Spacer()
                    }
                    if detailGoalList.count <= 4{
                        textFieldView()
                    }else{
                        Rectangle()
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .overlay{
                               Text("최대 5개 까지만 입력 가능해요")
                            }
                            .animation(.easeInOut(duration: 1) ,value: isShow)
                            .onAppear{
                                isShow.toggle()
                            }
                    }
                    Spacer()
                    addDetailListView()
                    Spacer()
                    createStar()
                }
                .padding(.horizontal,16)
                .onAppear{
                    foucused = true
                }
            }
            .navigationDestination(isPresented: $createGoal){
                GoalResultView(title: $title, goalDetail: $detailGoalText, detailGoalList: detailGoalList)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    @ViewBuilder
    func textFieldView()-> some View{
        TextField(
            "",
            text: $detailGoalText,
            prompt:
                Text("추가할 계획을 입력해주세요!")
                .bold()
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
            detailGoalListButton()
        }
    }
    @ViewBuilder
    func addDetailListView()-> some View{
        ScrollView{
            ForEach(detailGoalList, id:\.self){ item in
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundStyle(.white.gradient)
                    .overlay{
                        Text(item)
                            .font(.body)
                            .foregroundStyle(.black.gradient)
                    }
                    .animation(.easeInOut(duration: 0.5),value: isAddAnimation)
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
            .disabled(isEmpty)
        }
    }
    @ViewBuilder
    func detailGoalListButton()-> some View{
        HStack{
            Spacer()
            Button{
                detailGoalList.append(detailGoalText)
                detailGoalText = ""
                isAddAnimation.toggle()
            }label: {
                Text("추가")
                    .frame(height: 30)
                    .foregroundStyle(.black)
                    .padding(.horizontal,10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.white.gradient)
                    )
                    .padding(.horizontal,10)
            }
            .disabled(detailGoalText.isEmpty)
            .onChange(of: detailGoalList){ _ , _ in
                if detailGoalList.isEmpty{
                    isEmpty = true
                }else{
                    isEmpty = false
                }
            }
        }
    }
}

#Preview {
    GoalDetailView(title:.constant("운동하기"))
}
