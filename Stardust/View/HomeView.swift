//
//  ContentView.swift
//  Stardust
//
//  Created by sueun kim on 5/29/24.
//
import SwiftUI


struct HomeView: View {
    @FetchRequest(sortDescriptors: []) var plan: FetchedResults<Plan>
    @State private var createNewGoal: Bool = false
    @StateObject var viewModel: PlanViewModel = PlanViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                
                TimerView()
                if let errorMessage = viewModel.errorMessage{
                    Text(errorMessage)
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .frame(height: 300, alignment: .bottom)
                }else{
                    VStack{
                        ProverbView()
                        Spacer()
                            .frame(height: 150)
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
    }
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
                        .blur(radius: 1)
                }
                .foregroundStyle(Color.white)
        }
    }
}
#Preview{
    HomeView()
}
