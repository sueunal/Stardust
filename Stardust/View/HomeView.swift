//
//  ContentView.swift
//  Stardust
//
//  Created by sueun kim on 5/29/24.
//

import SwiftUI


struct HomeView: View {
    let gradient = LinearGradient(colors: [Color.black,Color.black,Color.black,Color.white],
                                  startPoint: .top, endPoint: .bottom)
    let graientBackground = AngularGradient(colors: [.black, .white], center: .center)
    @State private var isOnAppear: Bool = false
    @State private var createNewGoal: Bool = false
    @State private var isReady: Bool = false
    @StateObject var viewModel: PlanViewModel = PlanViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                ProverbView()
                VStack(){
                    Spacer()
                    ToDoListView()
                        .environmentObject(viewModel)
                    Text("남은 시간")
                        .font(AppFont.title2Bold)
                        .foregroundStyle(.white)
                    TimerView()
                    Spacer()
                        .frame(height: 200)
                    createNewGoalButton()
                    Spacer()
                        .frame(height: 200)
                }
                .padding(.horizontal,16)
                .navigationTitle("")
            }
        }
    }
    @ViewBuilder
    func createNewGoalButton()-> some View{
        NavigationLink {
            CreateGoal()
        } label: {
            Circle()
                .frame(width: 50,height: 50)
                .foregroundStyle(.white.opacity(1))
                .blur(radius: 1)
                .font(AppFont.bodyBold)
                .overlay{
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 25,height: 25)
                        .foregroundStyle(.black)
                }
        }
    }
}

#Preview{
    HomeView()
}
