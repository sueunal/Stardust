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
                        .italic()
                        .foregroundStyle(.white)
                        .padding(.vertical,2)
                    Text("- 피터 드러커 -")
                        .font(.subheadline)
                        .italic()
                        .foregroundStyle(.white)
                    Spacer()
                    CardOverlayView(title: title, goalDetail: goalDetail)
                        .rotation3DEffect(
                            .degrees(isFlipped ? 360 : 0),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .animation(.easeInOut(duration: 1.0), value: isFlipped)
                    Spacer()
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
}


struct CardOverlayView: View {
    let title: String
    let goalDetail: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(LinearGradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0), Color.white.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
            VStack(spacing: 0){
                Text("\(title)")
                    .font(AppFont.title2Bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 50)
                Divider()
                    .background(.white.opacity(0.3))
                    .frame(maxWidth: .infinity)
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
    GoalResultView(title: .constant("운동하기"), goalDetail: .constant("30분 걷기"))
}
