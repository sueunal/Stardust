//
//  PlanViewModel.swift
//  Stardust
//
//  Created by sueun kim on 6/4/24.
//

import SwiftUI
import Alamofire

struct GoalModel: Codable {
    let data, message, title: String
}

class PlanViewModel: ObservableObject{
    @Published var plans: [Plan] = []
    let localURL: String = "http://localhost:5000/api/data"
    let urlString: String = "https://665701489f970b3b36c78bd9.mockapi.io/plan"
    init(){
        self.requestGet()
    }
    func postGoal(_ title: String, _ message: String, _ date: String){
        let url = URL(string: localURL)!
        let parameter: Parameters? = [
            "title": title,
            "message": message,
            "data": date
        ]
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: GoalModel.self){ response in
            switch response.result{
            case .success(let data):
                print(data)
            case .failure(let fail):
                print(fail.localizedDescription)
            }
        }
    }
    func requestGet(){
        let url = URL(string: urlString)!
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
