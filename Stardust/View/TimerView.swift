//
//  TimerView.swift
//  Stardust
//
//  Created by sueun kim on 6/2/24.
//

import SwiftUI
import Combine

struct TimerView: View {
    @StateObject var timer = TimerManager()
    @State var isTimerOn: Bool = false
    @State private var cheerUpMessage: String = "오늘도 한 걸음 나아갈 당신을 응원할게요!"
    @State var userInfo: Any? = nil
    var body: some View {
        VStack {
            Text("남은 시간")
                .font(AppFont.title2Bold)
                .foregroundStyle(.white)
            Text("\(timer.remainingTime)")
                .font(.system(size: 80))
                .foregroundStyle(.white.opacity(0.8).gradient)
                .padding()
            Text(cheerUpMessage)
                .font(AppFont.bodyBold)
                .foregroundStyle(.white)
                .transition(.identity)
                .animation(.easeInOut(duration: 0.5), value: isTimerOn)
        }
        .animation(.easeInOut(duration: 0.5), value: isTimerOn)
        .onAppear{
            withAnimation{
                isTimerOn = true
            }
        }
    }
}


#Preview {
    TimerView()
}
