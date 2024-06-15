//
//  PlanViewModel.swift
//  Stardust
//
//  Created by sueun kim on 6/4/24.
//

import SwiftUI
import Alamofire

struct GoalModel: Codable {
    let title: String
    let messages: [String]
    let date: String
}
struct ResponseModel: Codable{
    let message: String
    let ID: String
}

class PlanViewModel: ObservableObject{
    @Published var plans: [Plan] = []
    let localURL: String = "http://localhost:12341"
    init(){
        
    }
    func addPlan(_ title: String, _ messages: [String], _ date: String){
        let url = "\(localURL)/add_plan"
        let parameter: Parameters? = [
            "PlanTitle": title,
            "PlanDetail": messages,
            "PlanAttainment": [false],
            "Date": date
        ]
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: ResponseModel.self){ response in
            switch response.result{
            case .success(let data):
                print(data.ID)
            case .failure(let fail):
                print(fail.localizedDescription)
            }
        }
    }
    func requestGet(){
        let url = "\(localURL)/get_plan"
        AF.request(url, method: .get).responseDecodable(of: [Plan].self) { response in
            switch response.result{
            case .success(let success):
                self.plans = success
            case .failure(let fail):
                print(fail.localizedDescription)
            }
        }
    }
}
