//
//  ToDoItem.swift
//  Stardust
//
//  Created by sueun kim on 6/3/24.
//
import SwiftUI


struct ToDoListView: View {
    @FetchRequest(sortDescriptors: []) var plans: FetchedResults<Plan>
    @Environment(\.managedObjectContext) var viewContext
    @State private var isComplete: Bool = false
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
                            LazyVGrid(columns: [GridItem(.fixed(150)),GridItem(.fixed(150))]){
                                toDoItemView(plan)
                            }
                        }
                    }
                }
                .padding(.horizontal,16)
            }
        }
    }
    @ViewBuilder
    func toDoItemView(_ plan: FetchedResults<Plan>.Element) -> some View{
        VStack{
            Text(plan.planTitle ?? "값을 불러올수없습니다.")
            Text(plan.date ?? "값을 불러올수없습니다.")
        }
        .padding(300)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
        )
    }
    func dataToString(_ timestamp: Int)-> String{
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        return dateFormatter.string(from: date)
    }
    func updatePlanComplete(){
        guard let plan = plans.first else {
           return
        }
        plan.isComplete.toggle()
        do {
           try viewContext.save()
        }catch{
            print("update error : \(error.localizedDescription)")
        }
    }
}

#Preview {
    ToDoListView()
}
