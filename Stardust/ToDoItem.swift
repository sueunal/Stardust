//
//  ToDoItem.swift
//  Stardust
//
//  Created by sueun kim on 6/3/24.
//
import SwiftUI


struct ToDoItem: View {
    let gardient = AngularGradient(colors: [.black, .white], center: .top)
    var body: some View {
        ZStack{
            gardient.ignoresSafeArea()
            VStack{
                ScrollView{
                    ForEach(0..<10){ item in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white.opacity(0.2))
                            .frame(height: 100)
                    }
                }
            }
            .padding(.horizontal,16)
        }
    }
}

#Preview {
    ToDoItem()
}
