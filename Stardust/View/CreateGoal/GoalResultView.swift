import SwiftUI
import Combine

struct GoalResultView: View {
    @State private var isFlipped: Bool = false
    @State private var showHomeView: Bool = false
    @State private var isOnAppear: Bool = false
    @Binding var title: String
    @Binding var goalDetail: String
    @StateObject var viewModel: PlanViewModel = PlanViewModel()
    let detailGoalList: [String]
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                VStack{
                    Spacer()
                    TimerView()
                    Spacer()
                        .frame(height: 16)
                    ProverbView()
                    Spacer()
                    //                    ResultPlanView(title: title, detailGoalList: detailGoalList)
                    Spacer()
                    CustomButton(buttonText: "확인"){
                        viewModel.addPlan(title, detailGoalList, transferToDate())
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
    func transferToDate()-> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: date)
    }
}

struct ResultPlanView: View {
    @State private var isOnAppaer: Bool = false
    let gradient = AngularGradient(colors: [.red.opacity(0.3), .cyan.opacity(0.3)], center: .center, angle: .degrees(0.5))
    let title: String
    let detailGoalList: [String]
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0){
                Spacer()
                    .frame(height: 32)
                Text("\(title)")
                    .font(AppFont.largeTitleBold)
                    .foregroundStyle(.white)
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 2)
                    .foregroundStyle(.white)
                    .padding(.horizontal,10)
                ForEach(detailGoalList, id: \.self){ detail in
                    Text("\(detail)")
                        .foregroundStyle(.white)
                        .font(AppFont.calloutBold)
                }
            }
            .padding(.horizontal,10)
            .background(
                Rectangle()
                    .fill(.brown.gradient.opacity(0.8))
                
            )
        }
        .frame(maxHeight: 300)
        .padding(.horizontal,10)
    }
}

#Preview{
    GoalResultView(title: .constant("운동하기"), goalDetail: .constant(" - 오늘의 계획 자세하게 입력\n - 오늘의 계획 자세하게 입력"), detailGoalList: ["운동하기","운동하기"])
}
