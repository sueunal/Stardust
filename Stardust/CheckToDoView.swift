//
//  CheckToDoView.swift
//  Stardust
//
//  Created by sueun kim on 6/5/24.
//

import SwiftUI

struct CheckToDoView: View {
    @State private var isCheck: Bool = false
    let title: String
    let message: String
    var body: some View {
        VStack{
            Text(title)
            Text(message)
        }
    }
}

#Preview {
    CheckToDoView()
}
