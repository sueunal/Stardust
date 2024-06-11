//
//  GoalPlan.swift
//  Stardust
//
//  Created by sueun kim on 6/4/24.
//

import Foundation

struct Plan: Codable, Identifiable{
    let id: String
    let title: String
    let messages: [String]
    let date: Int
    
    static let dummy = Plan(id: "", title: "", messages: ["",""], date: 10)
}

