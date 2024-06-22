//
//  Request.swift
//  Stardust
//
//  Created by Soom on 6/20/24.
//

import Foundation

struct RequestModel: Codable,Identifiable {
    let id = UUID()
    let PlanTitle: String
    let PlanDetail: [String]
    let PlanAttainment: [Bool]
    let Date: String
}
