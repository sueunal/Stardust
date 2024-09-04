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
                VStack{
                        TimerView()
                        
                        ProverbView()
                        Spacer()
                            .frame(height: 50)
                        HStack(spacing: 10){
                            createNewGoalButton()
                            
                            ToDoListView()
                        }
                    }
                    .padding(.horizontal,16)
                    .navigationTitle("")
                }
            }
            .environmentObject(viewModel)
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
            Text("메모 생성")
                .foregroundStyle(.black.opacity(1))
                .font(AppFont.title2Bold)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .blur(radius: 1)
                }
            //            Circle()
//                .frame(width: 50,height: 50)
//                .foregroundStyle(.white.opacity(1))
//                .blur(radius: 1)
//                .font(AppFont.bodyBold)
//                .overlay{
//                    Text("➕")
//                        .frame(width: 25,height: 25)
//                        .foregroundStyle(.black)
//                }
        }
    }
}

#Preview{
    HomeView()
}
