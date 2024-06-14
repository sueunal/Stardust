import SwiftUI
import Combine

struct GoalResultView: View {
    @State private var isFlipped: Bool = false
    @State private var showHomeView: Bool = false
    @State private var isOnAppear: Bool = false
    @Binding var title: String
    @Binding var goalDetail: String
    let detailGoalList: [String]
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                ResultPlanView(title: title, detailGoalList: detailGoalList)
                VStack{
                    Spacer()
                    TimerView()
                    Spacer()
                        .frame(height: 16)
                    ProverbView()
                    Spacer()
                    //                    resultPlanView()
                    Spacer()
                    CustomButton(buttonText: "확인"){
                        showHomeView.toggle()
                    }
                }
                .padding(.horizontal,16)
                .onAppear{
                    isOnAppear = true
                }
                .navigationDestination(isPresented: $showHomeView){
                    HomeView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct ResultPlanView: View {
    @State private var isOnAppaer: Bool = false
    let gradient = AngularGradient(colors: [.red.opacity(0.3), .cyan.opacity(0.3)], center: .center, angle: .degrees(0.5))
    let title: String
    let detailGoalList: [String]
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.white.opacity(0.2).gradient)
            VStack(alignment: .center){
                Spacer()
                    .frame(height: 32)
                Text("\(title)")
                    .font(AppFont.title1Bold)
                    .foregroundStyle(.white)
                ForEach(detailGoalList, id: \.self){ detail in
                    Text("\(detail)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(AppFont.bodyRegular)
                }
                Spacer()
            }
        }
        .frame(maxHeight: 300)
        .offset(x: 0 ,y: isOnAppaer ? 200 : -100)
        .padding(.horizontal,10)
        .onAppear{
            withAnimation (.easeInOut(duration: 2)){
                isOnAppaer = true
            }
        }
        .onDisappear{
            isOnAppaer = false
        }
    }
}

#Preview{
    GoalResultView(title: .constant("운동하기"), goalDetail: .constant(" - 오늘의 계획 자세하게 입력\n - 오늘의 계획 자세하게 입력"), detailGoalList: ["운동하기","운동하기"])
}
