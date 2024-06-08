//
//  ProverbView.swift
//  Stardust
//
//  Created by sueun kim on 5/31/24.
//
import SwiftUI

struct ProverbModel{
    let message: String
    let writer: String
}
struct ProverbView: View {
    let gradient = AngularGradient(colors: [.black, .white], center: .top)
    
    @State private var proverb: [ProverbModel] = [ProverbModel(message: "멈추지 않는 한, 얼마나 천천히 가는지는 중요하지 않다.", writer: "공자"),ProverbModel(message: "오늘 할 수 있는 일에 전력을 다하라. 그러면 내일에는 한걸음 더 진보한다.", writer: "뉴턴")]
    @State private var proverbIndex: Int = 0
    var body: some View {
        ZStack{
            gradient.ignoresSafeArea()
            VStack(spacing: 10){
                Text(proverb[proverbIndex].message)
                Text("- \(proverb[proverbIndex].writer) -")
            }
            .foregroundStyle(.white)
            .font(AppFont.headlineBold)
            .transition(.slide)
            .animation(.easeInOut(duration: 0.5))
        }
    }
}

#Preview {
    ProverbView()
}