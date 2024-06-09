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
    @State private var isEmpty: Bool = true
    @State private var isAddAnimation: Bool = false
    @State private var createGoal: Bool = false
    @State private var isShow: Bool = false
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
                        CustomTextField(text: $detailGoalText, promptText: "추가할 계획을 입력해주세요!")
                            .overlay{
                                detailGoalListButton()
                            }
                    }else{
                        Text("최대 5개 까지만 입력 가능해요")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                Rectangle()
                                    .stroke()
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                            )
                            .animation(.easeInOut(duration: 1),value: isShow)
                            .onAppear{
                                isShow.toggle()
                            }
                    }
                    Spacer()
                    addDetailListView()
                        .animation(.linear(duration: 0.5),value: isShow)
                    Spacer()
                    createStar()
                }
                .padding(.horizontal,16)
            }
            .navigationDestination(isPresented: $createGoal){
                GoalResultView(title: $title, goalDetail: $detailGoalText, detailGoalList: detailGoalList)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    @ViewBuilder
    func addDetailListView()-> some View{
        ScrollView{
            ForEach(detailGoalList.indices, id:\.self){ item in
                HStack{
                    Spacer()
                    Text(detailGoalList[item])
                        .font(.body)
                        .foregroundStyle(.black.gradient)
                    Spacer()
                    Button{
                        let index = detailGoalList.index(before:  item) + 1
                        detailGoalList.remove(at: index)
                    }label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                            .frame(width: 20,height: 30)
                    }
                    .padding(.trailing,10)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.gray.gradient.opacity(0.5))
                        .strokeBorder(lineWidth: 1)
                )
                .animation(.easeInOut(duration: 0.5),value: isAddAnimation)
            }
        }
        .defaultScrollAnchor(detailGoalList.count <=  5 ? .top : .bottom)
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
