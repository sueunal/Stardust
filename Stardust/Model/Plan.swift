//
//  GoalPlan.swift
//  Stardust
//
//  Created by sueun kim on 6/4/24.
//

import Foundation

struct Plan: Codable, Identifiable{
    let id: UUID
    let planTitle: String
    let planDetail: String
    let date: Date
    
    static let dummy = Plan(id: UUID(), planTitle: "", planDetail: "", date: .now)
}

