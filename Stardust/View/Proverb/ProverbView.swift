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
    @State private var proverbIndex: Int = 5
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Text(proverbViewModel.proverbs[proverbIndex].quote)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .font(AppFont.bodyBold)
                Rectangle()
                    .frame(width: 15,height: 1)
                Text(proverbViewModel.proverbs[proverbIndex].author)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white.gradient)
            .bold()
            .transition(.slide)
            .animation(.easeInOut(duration: 0.5), value: proverbIndex)
            .padding(20)
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
