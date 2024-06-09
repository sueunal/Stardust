//
//  ProverbView.swift
//  Stardust
//
//  Created by sueun kim on 5/31/24.
//
import SwiftUI

struct ProverbView: View {
   
    @StateObject private var proverbViewModel = ProverbViewModel()
    @State private var timer: Timer? = nil
    @State private var proverbIndex: Int = 0
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Text(proverbViewModel.proverbs[proverbIndex].quote)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                Text(proverbViewModel.proverbs[proverbIndex].author)
            }
            .foregroundStyle(.white)
            .font(.subheadline)
            .transition(.slide)
            .animation(.easeInOut(duration: 0.5))
            .padding(.horizontal,10)
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    private func startTimer() {
        let proverbsMax = proverbViewModel.proverbs.count - 1
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
            if proverbIndex < proverbsMax{
                proverbIndex += 1
            }
        }
    }
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    ProverbView()
}
