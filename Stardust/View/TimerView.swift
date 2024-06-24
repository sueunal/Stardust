//
//  TimerView.swift
//  Stardust
//
//  Created by sueun kim on 6/2/24.
//

import SwiftUI

struct TimerView: View {
    @StateObject var timeManager: TimeManager = TimeManager()
    @State var isTimerState: Bool = false
    @State private var timerAnimationColor: [Color] = [.accentColor,.green,.orange]
    
    @State var userInfo: Any? = nil
    var body: some View {
        VStack {
            if isTimerState{
                Text("남은 시간")
                    .font(AppFont.title1Bold)
                    .foregroundStyle(.white)
                    .opacity(isTimerState ? 1 : 0)
                    .padding(.bottom, -15)
            }
            
            Spacer()
                .frame(height: 5)
            Text("\(timeManager.remainingTime)")
                .font(.system(size: 80))
                .frame(height: 100)
                .foregroundStyle(.white.opacity(0.9))
                .opacity(isTimerState ? 1 : 0)
                .padding(15)
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 2)){
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
