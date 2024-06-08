//
//  TimerView.swift
//  Stardust
//
//  Created by sueun kim on 6/2/24.
//

import SwiftUI
import Combine

struct TimerView: View {
    @State private var currentTime: Date = Date()
    let timer = TimageManager()

    var body: some View {
        VStack {
            Text("\(currentTime)")
                .font(.system(size: 80))
                .foregroundStyle(.white.opacity(0.8).gradient)
                .padding()
        }
        .onReceive(timer.currentTimePublisher) { newCurrentTime in
             self.currentTime = newCurrentTime
           }
    }
}


#Preview {
    TimerView()
}
