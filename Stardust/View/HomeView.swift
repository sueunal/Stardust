//
//  ContentView.swift
//  Stardust
//
//  Created by sueun kim on 5/29/24.
//
import SwiftUI


struct HomeView: View {
    @State private var createNewGoal: Bool = false
    @State private var cheerUpMessage: String = "오늘도 한 걸음 나아갈 당신을 응원할게요!"
    @State var viewModel: PlanViewModel = PlanViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                VStack(){
                    Spacer()
                    ToDoListView(viewModel: viewModel)
                    TimerView()
                    ProverbView()
                    Spacer()
                        .frame(height: 150)
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
