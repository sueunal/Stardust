//
//  ContentView.swift
//  Stardust
//
//  Created by sueun kim on 5/29/24.
//
import SwiftUI


struct HomeView: View {
    @State private var createNewGoal: Bool = false
    @StateObject var viewModel: PlanViewModel = PlanViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
//                if let errorMessage = viewModel.errorMessage{
//                    Text(errorMessage)
//                        .foregroundStyle(.black)
//                        .font(.title)
//                }else{
                    BackgroundView()
                    VStack(){
                        Spacer()
                        ToDoListView()
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
            .environmentObject(viewModel)
            .onAppear{
            }
        }
//    }
    func akeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
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
                    Text("➕")
                        .frame(width: 25,height: 25)
                        .foregroundStyle(.black)
                }
        }
    }
}

#Preview{
    HomeView()
}
