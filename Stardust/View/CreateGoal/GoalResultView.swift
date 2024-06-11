import SwiftUI
import Combine

struct GoalResultView: View {
    let gradient = AngularGradient(colors: [.black, .white], center: .top)
    @State private var isFlipped: Bool = false
    @State private var showHomeView: Bool = false
    @Binding var title: String
    @Binding var goalDetail: String
    let detailGoalList: [String]
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    Spacer()
                    TimerView()
                    Spacer()
                        .frame(height: 16)
                    ProverbView()
                    Spacer()
                    resultPlanView()
                    Spacer()
                    CustomButton(buttonText: "확인"){
                        showHomeView.toggle()
                    }
                }
                .padding(.horizontal,16)
                .onAppear{
                    isFlipped.toggle()
                }
                .navigationDestination(isPresented: $showHomeView){
                    HomeView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
    @ViewBuilder
    func resultPlanView()-> some View{
        Text(title)
            .font(AppFont.title1Bold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        ForEach(detailGoalList, id: \.self){ deatailGoalItem in
            Text(" - \(deatailGoalItem)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(AppFont.bodyRegular)
                .foregroundStyle(.white)
        }
    }
}


#Preview{
    GoalResultView(title: .constant("운동하기"), goalDetail: .constant(" - 오늘의 계획 자세하게 입력\n - 오늘의 계획 자세하게 입력"), detailGoalList: ["운동하기","운동하기"])
}
