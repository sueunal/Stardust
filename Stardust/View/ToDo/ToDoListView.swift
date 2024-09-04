//
//  ToDoListView.swift
//  Stardust
//
//  Created by sueun kim on 6/2/24.
//

import SwiftUI

struct ToDoListView: View {
    @EnvironmentObject var viewModel: PlanViewModel
    @State private var showToDoView: Bool = false
    var body: some View {
        NavigationStack{
            VStack{
                Button{
                    showToDoView.toggle()
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
            .navigationDestination(isPresented: $showToDoView){
                ToDoItem()
                    .environmentObject(viewModel)
            }
        }
    }
}
#Preview {
    ToDoListView()
        .environmentObject(PlanViewModel())
}
