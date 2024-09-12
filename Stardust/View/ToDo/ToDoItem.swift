//
//  ToDoItem.swift
//  Stardust
//
//  Created by sueun kim on 6/3/24.
//
import SwiftUI


struct ToDoItem: View {
    @FetchRequest(sortDescriptors: []) var plans: FetchedResults<Plan>
    @EnvironmentObject var viewModel: PlanViewModel
    let gardient = AngularGradient(colors: [.black, .white], center: .top)
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                VStack{
                    Text("총 \(plans.count) 개!")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(AppFont.title1Bold)
                        .foregroundStyle(.white)
                    ScrollView{
                        ForEach(plans){ plan in
                            Text(plan.isComplete.description)
                                .font(.largeTitle)
                                .foregroundStyle(.black)
                        }
                    }
                }
                .padding(.horizontal,16)
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
