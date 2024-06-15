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
    @State private var timerAnimationColor: [Color] = [.accentColor,.green,.orange]
    
    @State var userInfo: Any? = nil
    var body: some View {
        VStack {
            Text("남은 시간")
                .font(AppFont.title1Bold)
                .foregroundStyle(.white)
            Spacer()
                .frame(height: 30)
            Text("\(timer.remainingTime)")
                .font(.system(size: 80))
                .foregroundStyle(.white.opacity(0.8).gradient)
                .padding(EdgeInsets(top: -30, leading:15, bottom: 15, trailing: 15))
                .animation(.linear(duration: 2),value:  isTimerState)
        }
        .onAppear{
            withAnimation{
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
