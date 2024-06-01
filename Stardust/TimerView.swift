//
//  TimerView.swift
//  Stardust
//
//  Created by sueun kim on 6/2/24.
//

import SwiftUI

struct TimerView: View {
    @State private var timeRemaining: TimeInterval = 0
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text(timeString(from: timeRemaining))
                .font(.system(size: 80))
                .foregroundStyle(.white.opacity(0.3))
                .padding()
        }
        .onAppear{
           startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate() // 기존 타이머가 있으면 무효화합니다.
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateTimeRemaining()
        }
    }

    func updateTimeRemaining() {
        let now = Date()
        let calendar = Calendar.current
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: now)!)
        timeRemaining = tomorrow.timeIntervalSince(now)
    }

    func timeString(from timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}


#Preview {
    TimerView()
}
