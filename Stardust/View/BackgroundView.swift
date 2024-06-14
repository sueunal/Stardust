//
//  BackgroundView.swift
//  Stardust
//
//  Created by sueun kim on 6/12/24.
//

import SwiftUI

struct BackgroundView: View {
    let topGradient = LinearGradient(colors: [.red.opacity(0.3), .accentColor.opacity(0.5)], startPoint: .top, endPoint: .bottomTrailing)
    @State private var isOnAppear: Bool = false
    var body: some View {
        VStack{
            Color.white
                .overlay{
                    Circle()
                        .fill(topGradient)
                        .scaleEffect(isOnAppear ? 3 : 0.2)
                        .frame(width: 300,height: 300)
                        .animation(.easeInOut(duration: 0.5), value:  isOnAppear)
                        .offset(y: isOnAppear ? -200 : 0)
                }
        }
        .ignoresSafeArea()
        .onAppear{
            isOnAppear = true
        }
        .onDisappear{
            isOnAppear = false
        }
    }
}

#Preview {
    BackgroundView()
}
