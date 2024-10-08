//
//  ContentView.swift
//  Stardust
//
//  Created by sueun kim on 5/29/24.
//
import SwiftUI


struct HomeView: View {
    @FetchRequest(sortDescriptors: []) var plans: FetchedResults<Plan>
    @Environment(\.managedObjectContext) var moc
    
    @State private var createNewGoal: Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                
                    VStack{
                        TimerView()
                        
                        ProverbView()
                        
                        HStack(spacing: 10){
                            createNewGoalButton()
                            
                            toDoListView()
                        }
                    }
                    .padding(.horizontal,16)
                    .environment(\.managedObjectContext, moc)
                }
            }
    }
    @ViewBuilder
    func toDoListView()->some View{
        VStack{
            NavigationLink{
                ToDoItem()
                    .environment(\.managedObjectContext, moc)
            }label: {
                Text("작성한 메모")
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .font(AppFont.title2Bold)
                    .frame(height: 150)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                            .blur(radius: 1)
                    )
            }
        }
    }
    
    @ViewBuilder
    func createNewGoalButton()-> some View{
        NavigationLink {
            CreateGoal()
                .environment(\.managedObjectContext, moc)
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
