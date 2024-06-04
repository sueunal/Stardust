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
        NavigationStack{
            ZStack{
                gardient.opacity(0.8).ignoresSafeArea()
                VStack{
                    ScrollView{
                        ForEach(0..<5){ item in
                            NavigationLink{
                                Text("\(item)")
                            }label: {
                                Text("\(item)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 100, alignment: .top)
                                    .foregroundStyle(.white)
                                    .padding([.top,.leading], 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.white.opacity(0.3))
                                            
                                    )
                            }
                        }
                    }
                }
                .padding(.horizontal,16)
            }
        }
    }
}

#Preview {
    ToDoItem()
}
