//
//  ToDoItem.swift
//  Stardust
//
//  Created by sueun kim on 6/3/24.
//
import SwiftUI


struct ToDoItem: View {
    @ObservedObject var viewModel: PlanViewModel = PlanViewModel()
    let gardient = AngularGradient(colors: [.black, .white], center: .top)
    var body: some View {
        NavigationStack{
            ZStack{
                gardient.opacity(0.8).ignoresSafeArea()
                VStack{
                    ScrollView{
                        Text("총 \(viewModel.plans.count) 개!")
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .font(AppFont.title1Bold)
                            .foregroundStyle(.white)
                        ForEach(viewModel.plans) { plan in
                            NavigationLink{
                                Text("\(plan.title)")
                            }label: {
                                Text("\(plan.title)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 100, alignment: .top)
                                    .font(AppFont.title1Bold)
                                    .foregroundStyle(.white)
                                    .overlay{
                                        VStack{
                                            Text("\(dataToString(plan.data))")
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                                .foregroundStyle(.white.opacity(0.4))
                                                .font(AppFont.bodyRegular)
                                                .padding(.horizontal,10)
                                            Spacer()
                                        }
                                    }
                                    .padding([.top,.leading], 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.white.opacity(0.3))
                                            .overlay{
                                                Text(plan.message)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .foregroundStyle(.white)
                                                    .font(AppFont.bodyBold)
                                                    .padding(.horizontal, 10)
                                            }
                                    )
                            }
                        }
                    }
                }
                .padding(.horizontal,16)
                .onAppear{
                    viewModel.requestGet()
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
}
