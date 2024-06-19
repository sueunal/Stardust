//
//  ContentView.swift
//  Stardust
//
//  Created by sueun kim on 5/29/24.
//
import SwiftUI


struct HomeView: View {
    @State private var createNewGoal: Bool = false
    @State var viewModel: PlanViewModel = PlanViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                if viewModel.errorMessage.isEmpty{
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
                }else{
                    Color.black.ignoresSafeArea()
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
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
