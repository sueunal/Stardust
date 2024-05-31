//
//  CreateStarView.swift
//  Stardust
//
//  Created by sueun kim on 5/31/24.
//

import Combine
import SwiftUI


struct Dot: Identifiable, Codable{
    let id = UUID()
    var position: CGPoint
}

extension UserDefaults {
    private enum Keys {
        static let dots = "dots"
    }
    
    func saveDots(_ dots: [Dot]) {
        if let encoded = try? JSONEncoder().encode(dots) {
            set(encoded, forKey: Keys.dots)
        }
    }
    
    func loadDots() -> [Dot] {
        if let savedDotsData = data(forKey: Keys.dots),
           let savedDots = try? JSONDecoder().decode([Dot].self, from: savedDotsData) {
            return savedDots
        }
        return []
    }
}

class DotsViewModel: ObservableObject {
    @Published var dots: [Dot] = []
    private var timer: AnyCancellable?
    private let centerPoint = CGPoint(x: 150, y: 300)
    private let duration: Double = 1.0
    
    init() {
        loadDots()
    }
    
    func addDot() {
        let newDot = Dot(position: CGPoint(x: CGFloat.random(in: 0...300), y: CGFloat.random(in: 0...600)))
        dots.append(newDot)
        saveDots()
    }
    
    func startAnimation() {
        timer?.cancel()
        timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect().sink { _ in
            self.animateDots()
        }
    }
    
    func animateDots() {
        withAnimation(.linear(duration: duration)) {
            self.dots = self.dots.map { dot in
                let dx = self.centerPoint.x - dot.position.x
                let dy = self.centerPoint.y - dot.position.y
                let distance = sqrt(dx * dx + dy * dy)
                let angle = atan2(dy, dx)
                let speed = distance / CGFloat(self.duration * 50) // 50는 타이머 간격 0.02초의 역수
                
                let newX = dot.position.x + cos(angle) * speed
                let newY = dot.position.y + sin(angle) * speed
                return Dot(position: CGPoint(x: newX, y: newY))
            }
        }
    }
    
    func saveDots() {
        UserDefaults.standard.saveDots(dots)
    }
    
    func loadDots() {
        dots = UserDefaults.standard.loadDots()
    }
    
    func stopAnimation() {
        timer?.cancel()
    }
}
struct CreateStarView: View {
    @StateObject private var viewModel = DotsViewModel()
    
    var body: some View {
        ZStack {
            ForEach(viewModel.dots) { dot in
                Star(count: 6, innerRatio: 10)
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
                    .shadow(color: .yellow,radius: 0.5)
                    .position(dot.position)
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.startAnimation()
        }
        .onDisappear {
            viewModel.stopAnimation()
        }
        .overlay(
            VStack {
                Spacer()
                Button(action: {
                    viewModel.addDot()
                }) {
                    Text("Add Dot")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        )
    }
}
#Preview{
    CreateStarView()
}
