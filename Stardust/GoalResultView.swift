import SwiftUI
import Combine

struct GoalResultView: View {
    let backgroundColor = AngularGradient(colors: [.white, .black], center: .bottomTrailing)
    @State private var isFlipped: Bool = false
    @State private var showHomeView: Bool = false
    @Binding var title: String
    @Binding var goalDetail: String
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor.ignoresSafeArea()
                VStack{
                    Spacer()
                    TimerView()
                    Text("오늘도 한 걸음 나아간 당신을 기대할게요!")
                        .font(AppFont.bodyBold)
                        .foregroundStyle(.white)
                    Spacer()
                        .frame(height: 16)
                    Text("미래를 예측하는 가장 좋은 방법은 그것을 창조하는 것이다.")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.vertical,2)
                    Text("- 피터 드러커 -")
                        .font(.subheadline)
                        .italic()
                        .foregroundStyle(.white)
                    Spacer()
                    CardOverlayView(title: title, goalDetail: goalDetail)
                    Spacer()
                    completeButton()
                }
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
    func completeButton()-> some View{
        Button{
            showHomeView.toggle()
        }label: {
            Text("확인")
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.background.opacity(0.8))
                )
                .shadow(radius: 1,y: 2)
        }
        .padding(.horizontal,16)
        .padding(.vertical,16)
    }
}


struct CardOverlayView: View {
    let title: String
    let goalDetail: String
    var body: some View {
        ZStack(alignment:.center){
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(LinearGradient(colors: [Color.white.opacity(0.3), Color.white.opacity(1), Color.white.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
            VStack(spacing: 0){
                Text("\(title)")
                    .font(AppFont.title2Bold)
                    .foregroundStyle(.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 50)
                Divider()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .overlay(.white.opacity(0.3))
                Spacer()
                    .frame(height: 32)
                Text(goalDetail)
                    .font(.custom("Tamil Sangam MN", size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding(.horizontal,16)
        }
        .padding(.horizontal,16)
        .frame(height: 300)
    }
}



#Preview{
    GoalResultView(title: .constant("운동하기"), goalDetail: .constant(" - 오늘의 계획 자세하게 입력\n - 오늘의 계획 자세하게 입력"))
}
