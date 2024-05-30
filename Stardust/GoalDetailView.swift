//
//  GoalDetailView.swift
//  Stardust
//
//  Created by sueun kim on 5/31/24.
//

import SwiftUI

struct GoalDetailView: View {
    let gradiant =  LinearGradient(colors: [.black.opacity(15),.white], startPoint: .top, endPoint: .bottom)
    @Binding var title: String
    var body: some View {
        NavigationStack{
            ZStack{
                gradiant.ignoresSafeArea()
                VStack{
                    Text("\(title) 목표의 세부 계획을 작성해주세요!")
                        .font(AppFont.title1Bold)
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    GoalDetailView(title:.constant("운동하기"))
}
