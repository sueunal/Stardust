//
//  TimerView.swift
//  Stardust
//
//  Created by sueun kim on 6/2/24.
//

import SwiftUI
import Combine

struct TimerView: View {
    @ObservedObject var timer = TimerManager()
    
    var body: some View {
        VStack {
            Text("남은 시간")
                .font(AppFont.title2Bold)
                .foregroundStyle(.white)
            Text("\(timer.remainingTime)")
                .font(.system(size: 80))
                .foregroundStyle(.white.opacity(0.8).gradient)
                .padding()
            Text("오늘도 한 걸음 나아갈 당신을 응원할게요!")
                .font(AppFont.bodyBold)
                .foregroundStyle(.white)
        }
    }
}


#Preview {
    TimerView()
}
