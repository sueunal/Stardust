//
//  ToDoItem.swift
//  Stardust
//
//  Created by sueun kim on 6/3/24.
//
import SwiftUI


struct ToDoItem: View {
    @EnvironmentObject var viewModel: PlanViewModel
    let gardient = AngularGradient(colors: [.black, .white], center: .top)
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    ScrollView{
                        Text("총 \(viewModel.plans.count) 개!")
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .font(AppFont.title1Bold)
                            .foregroundStyle(.white)
                        ForEach(viewModel.plans) { plan in
                            NavigationLink{
                                CheckToDoView(title: plan.title, messages: plan.messages)
                            }label: {
                                ToDoItems(title: plan.title, messages: plan.messages, date: "2024:11:12")
                            }
                            Spacer()
                                .frame(height: 10)
                        }
                    }
                    .padding(.horizontal,16)
                    .onAppear{
                        viewModel.requestGet()
                    }
                }
            }
        }
    }
    func dataToString(_ timestamp: Int)-> String{
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ToDoItem()
        .environmentObject(PlanViewModel())
}
