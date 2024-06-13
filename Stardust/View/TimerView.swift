//
//  TimerView.swift
//  Stardust
//
//  Created by sueun kim on 6/2/24.
//

import SwiftUI

struct TimerView: View {
    @StateObject var timer = TimerManager()
    @State var isTimerState: Bool = false
    @State private var cheerUpMessage: String = "오늘도 한 걸음 나아갈 당신을 응원할게요!"
    @State private var timerAnimationColor: [Color] = [.accentColor,.green,.orange]
    
    @State var userInfo: Any? = nil
    var body: some View {
        VStack {
            Text("남은 시간")
                .font(AppFont.title2Bold)
                .foregroundStyle(.white)
            Text("\(timer.remainingTime)")
                .font(.system(size: 80))
                .foregroundStyle(.white.opacity(0.8).gradient)
                .scaleEffect(isTimerState ? 1 : 0.5)
                .padding()
            Text(cheerUpMessage)
                .font(AppFont.bodyBold)
                .foregroundStyle(.white)
                .transition(.identity)
                .animation(.easeInOut(duration: 0.5), value: isTimerState)
        }
        .onAppear{
            withAnimation(.easeIn(duration: 2)){
                isTimerState = true
            }
        }
        .onDisappear{
            isTimerState = false
        }
    }
}


#Preview {
    TimerView()
}
