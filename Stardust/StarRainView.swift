//
//  StarRainView.swift
//  Stardust
//
//  Created by sueun kim on 5/30/24.
//

import SwiftUI

struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let starExtrusion: CGFloat = rect.width / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let pointsOnStar = 3
       
        let adjustment = CGFloat(Double.pi / 2.0)
        for i in 0..<pointsOnStar {
            let angle = (Double(i) * (360.0 / Double(pointsOnStar))) * Double.pi / 180 - Double(adjustment)
            let point = CGPoint(
                x: center.x + CGFloat(cos(angle)) * starExtrusion,
                y: center.y + CGFloat(sin(angle)) * starExtrusion
            )
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}

struct Star: View {
    var body: some View {
        StarShape()
            .fill(LinearGradient(colors: [.yellow.opacity(0.6), .white], startPoint: .top, endPoint: .bottom))
    }
}

struct FallingStar: View {
    let scale: Double
    let animationDuration: Double
    private let offsetXRatio: Double = .random(in: 0.01...3)
    
    @State private var offsetYRatio: Double = -0.3
    var body: some View {
        GeometryReader { screen in
            Star()
                .frame(width: 8 * scale, height: 8 * scale)
                .offset(x: screen.size.width * offsetXRatio,
                        y: screen.size.height * offsetYRatio)
                .onAppear {
                    withAnimation(.linear(duration: animationDuration)) {
                        offsetYRatio = 1.2
                    }
                }
                .background(
                    Star()
                        .frame(width: 16 * scale, height: 16 * scale)
                        .offset(x: screen.size.width * offsetXRatio,
                                y: screen.size.height * offsetYRatio)
                        .opacity(0.5)
                        .blur(radius: 3)
                        .animation(.linear(duration: animationDuration * 0.8))
                )
        }
    }
}

struct Raining: View {
    @State private var stars: [FallingStarItem] = []
    
    var body: some View {
            ZStack {
                Color.black.ignoresSafeArea()
                ForEach(stars) {
                    $0.star
                }
            }
            .ignoresSafeArea()
            .onAppear {
                startFalling()
            }
    }
    
    private func startFalling() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .random(in: 0.08...0.15)) {
            addStar()
            startFalling()
        }
    }
    
    private func addStar() {
        let newStarId = UUID()
        let scale = Double.random(in: 0.2...1.3)
        let fallDuration = 3 / scale
        
        let star = FallingStar(scale: scale,
                               animationDuration: fallDuration)
        
        stars.append(FallingStarItem(id: newStarId,
                                     star: star))
        
        removeStar(id: newStarId, after: fallDuration + 0.1)
    }
    
    private func removeStar(id: UUID, after: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            guard let starPosition = stars.firstIndex(where: { $0.id == id }) else { return }
            
            stars.remove(at: starPosition)
        }
    }
}

struct FallingStarItem: Identifiable {
    let id: UUID
    let star: FallingStar
}

#Preview{
    Raining()
}
