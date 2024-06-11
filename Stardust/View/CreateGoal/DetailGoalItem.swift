//
//  DetailGoalItem.swift
//  Stardust
//
//  Created by sueun kim on 6/9/24.
//

import SwiftUI

struct DetailGoalItem: View {
    @Binding var detailGoalList: String
    
    var body: some View {
        ScrollView{
            HStack{
                Spacer()
                Text(detailGoalList)
                    .font(.body)
                    .foregroundStyle(.black.gradient)
                Spacer()
                Button{
                    
                }label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.white)
                        .frame(width: 20,height: 30)
                }
                .padding(.trailing,10)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.gradient.opacity(0.5))
                    .strokeBorder(lineWidth: 1)
            )
        }
        .defaultScrollAnchor(detailGoalList.count <=  5 ? .top : .bottom)
    }
}

#Preview {
    DetailGoalItem(detailGoalList: .constant("asdfa"))
}
