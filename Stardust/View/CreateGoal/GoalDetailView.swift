//
//  GoalDetailView.swift
//  Stardust
//
//  Created by sueun kim on 5/31/24.
//

import SwiftUI

struct GoalDetailView: View {
    @Binding var title: String
    @State private var warningEffect: CGFloat = 0
    @State var detailGoalText: String = ""
    @State var detailGoalList: [String] = []
    @State private var isEmpty: Bool = true
    @State private var isAddAnimation: Bool = false
    @State private var createGoal: Bool = false
    @State private var isShow: Bool = false
    @State private var showHomeView: Bool = false

    @FetchRequest(sortDescriptors: []) var plan: FetchedResults<Plan>
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                VStack{
                    Spacer()
                        .frame(height: 32)
                    titleMessage()
                    Spacer()
                        .frame(height: 32)
                    textFieldView()
                    
                    addDetailListView()
                    Spacer()
                    CustomButton(buttonText: "목표 생성하기") {
                        let plan = Plan(context: moc)
                        plan.id = UUID()
                        plan.planTitle = title
                        plan.isComplete = false
                        plan.date = transferToDate()
                        try? moc.save()
                        showHomeView.toggle()
                    }
                    .disabled(detailGoalList.isEmpty)
                }
                .padding(.horizontal,16)
            }
            .navigationDestination(isPresented: $showHomeView){
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
     func transferToDate()-> String{
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: date)
    }
    @ViewBuilder
    func titleMessage()-> some View{
        HStack{
            Text("\(title) 목표의 자세한 계획을 추가해주세요")
                .font(AppFont.title1Bold)
                .foregroundStyle(.white)
            Spacer()
        }
    }
    @ViewBuilder
    func textFieldView()-> some View{
        if detailGoalList.count <= 4{
            CustomTextField(text: $detailGoalText, promptText: "추가할 계획을 입력해주세요!")
                .overlay{
                    detailGoalListButton()
                }
        }else{
            Text("최대 5개 까지만 입력 가능해요")
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundStyle(.white)
                .background(
                    Rectangle()
                        .strokeBorder(lineWidth: 2)
                        .frame(height: 50)
                        .foregroundColor(.white)
                )
                .warning(warningEffect)
                .animation(.bouncy,value: isShow)
                .onAppear{
                    warningEffect += 1
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
                        isAddAnimation =  false
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
                        .stroke()
                )
                .animation(.easeIn(duration: 0.5),value: isAddAnimation)
            }
        }
        .defaultScrollAnchor(detailGoalList.count <=  5 ? .top : .bottom)
    }
    @ViewBuilder
    func detailGoalListButton()-> some View{
        HStack{
            Spacer()
            Button{
                detailGoalList.append(detailGoalText)
                detailGoalText = ""
                withAnimation {
                    isAddAnimation.toggle()
                }
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

extension View {
    func warning(_ interval: CGFloat) -> some View {
        self.modifier(WarningEffect(interval))
            .animation(.easeOut(duration: 0.4), value: interval)
    }
}

struct WarningEffect: GeometryEffect {
    var animatableData: CGFloat
    var amount: CGFloat = 6
    var shakeCount = 6
    
    init(_ interval: CGFloat) {
        self.animatableData = interval
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * CGFloat(shakeCount) * .pi), y: 0))
    }
}


#Preview {
    GoalDetailView(title:.constant("운동하기"))
}
