//
//  GoalPlan.swift
//  Stardust
//
//  Created by sueun kim on 6/4/24.
//

import Foundation

struct Plan: Codable, Identifiable{
    let id: String
    let title, message: String
    let data: Int
    
    static let dummy = Plan(id: "", title: "", message: "", data: 10)
}

