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
    let gridItem = Array(repeating: GridItem(.flexible()), count: 2)
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                VStack{
                    Text("오늘 달성할 목표: \(plans.count)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(AppFont.title1Bold)
                        .foregroundStyle(.white)
                    ScrollView{
                        LazyVStack{
                            ForEach(plans){ plan in
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
        VStack(alignment: .leading, spacing: 8){
            HStack(alignment: .center){
                VStack(alignment: .leading){
                    Text("Design")
                        .foregroundStyle(.blue)
                    Text(plan.planTitle ?? "값을 불러올수없습니다.")
                        .font(.title)
                }
                .padding(.trailing,2)
                Spacer()
                Image(systemName: "ellipsis")
                    .padding(.horizontal,5)
                    .padding(.vertical,9)
                    .foregroundStyle(.black)
                    .background(
                        Circle()
                            .stroke()
                            .fill(.gray)
                            .frame(width: 24,height: 24)
                    )
            }
            .padding(.top, 14)
            Text("Progress")
                .font(.body)
                .foregroundStyle(.gray)
            ProgressView(value: 30, total: 100)
                .frame(width: 144)
                .frame(height: 4)
            HStack(spacing: 6){
                Text("30%")
                    .font(.subheadline)
            }
            HStack{
                Text(plan.date ?? "값을 불러올수없습니다.")
                Spacer()
                Text("High")
                    .foregroundStyle(.white)
                    .padding(.vertical,4)
                    .padding(.horizontal,19)
                    .background(
                        RoundedRectangle(cornerRadius: 41)
                            .fill(.blue)
                    )
            }
            .padding(.bottom,14)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal,14)
        .frame(height: 180)
        .background(
            RoundedRectangle(cornerRadius: 11)
                .stroke()
                .fill(.gray)
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
