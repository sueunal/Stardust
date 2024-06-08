import SwiftUI
import Combine

final class TimageManager {
    let currentTimePublisher = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
    let cancellable: AnyCancellable?

    init() {
        self.cancellable = currentTimePublisher.connect() as? AnyCancellable
    }
    deinit {
        self.cancellable?.cancel()
    }
}

