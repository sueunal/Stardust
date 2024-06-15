import SwiftUI
import Combine

final class TimeManager: ObservableObject {
    @Published var remainingTime: String = "00:00:00"
    private var cancellable: AnyCancellable?
    
    init() {
        startTimer()
    }
    private func startTimer() {
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateRemainingTime()
            }
    }
    private func updateRemainingTime() {
        let currentTime = Date()
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: currentTime).addingTimeInterval(24 * 60 * 60) // 자정 시간
        
        let timeInterval = midnight.timeIntervalSince(currentTime)
        
        if timeInterval > 0 {
            let hours = Int(timeInterval) / 3600
            let minutes = (Int(timeInterval) % 3600) / 60
            let seconds = Int(timeInterval) % 60
            remainingTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            remainingTime = "00:00:00"
            cancellable?.cancel()
            cancellable = nil
        }
    }
}

