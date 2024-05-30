//
//  ContentView.swift
//  Stardust
//
//  Created by sueun kim on 5/29/24.
//

import SwiftUI


struct HomeView: View {
    @State private var star: [Int] = []
    let gradient = LinearGradient(colors: [Color.black,Color.black,Color.black,Color.white],
                                  startPoint: .top, endPoint: .bottom)
    @State private var isOnAppear: Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                gradient.ignoresSafeArea()
                Raining()
                VStack{
                    if star.isEmpty{
                        Group{
                            Text("하늘에 별이 존재하지 않아요!")
                                .foregroundStyle(.white.gradient)
                                .font(AppFont.title1Bold)
                            Text("오늘 하루 목표를 추가하고 별을 생성해 보세요")
                                .foregroundStyle(.white.gradient)
                                .font(AppFont.title1Bold)
                        }
                        .animation(.easeInOut(duration: 1.5))
                        ProverbView()
                        Spacer()
                    }
                    NavigationLink {
                        CreateGoal()
                    } label: {
                        Text("별 만들기")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .font(AppFont.bodyBold)
                            .background(RoundedRectangle(cornerRadius: 8)
                                .fill(.white.gradient.opacity(0.25))
                                .shadow(radius: 0.10)
                                .frame(height: 50)
                                .blendMode(.normal)
                                .shadow(radius: 5)
                                        )
                    }
                    Spacer()
                        .frame(height: 200)
                }
                .onAppear{
                    withAnimation{
                        isOnAppear.toggle()
                    }
                }
                .padding(.horizontal,16)
            }
            .navigationTitle("")
            .accentColor(.black)
        }
    }
}
struct ToDoView: View {
    var body: some View {
        VStack{
           Text("오늘 이룰 것들")
        }
    }
}
struct SharePlanView: View {
    var body: some View {
        VStack{
           Text("친구들이 이룰 것들 ")
        }
    }
}
#Preview{
 HomeView()
}
