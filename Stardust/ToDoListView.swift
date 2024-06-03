//
//  ToDoListView.swift
//  Stardust
//
//  Created by sueun kim on 6/2/24.
//

import SwiftUI

struct ToDoListView: View {
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 32)
            Button{
                
            }label: {
                Image(systemName: "list.bullet")
                    .resizable()
                    .frame(width: 15,height: 15)
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
    }
}

#Preview {
    ToDoListView()
}
