//
//  ToDoListView.swift
//  Stardust
//
//  Created by sueun kim on 6/2/24.
//

import SwiftUI

struct ToDoListView: View {
    @State private var showToDoView: Bool = false
    @EnvironmentObject var viewModel: PlanViewModel
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Spacer()
                        .frame(height: 32)
                    Button{
                        showToDoView.toggle()
                    }label: {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .frame(width: 10,height: 10)
                            .foregroundStyle(.black)
                            .padding(7)
                            .background(
                                Circle()
                                    .fill(.white)
                            )
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .shadow(radius: 1,y: 2)
                    }
                    Spacer()
                }
                .navigationDestination(isPresented: $showToDoView){
                    ToDoItem()
                        .environmentObject(viewModel)
                }
            }
        }
    }
}
#Preview {
    ToDoListView()
        .environmentObject(PlanViewModel())
}
