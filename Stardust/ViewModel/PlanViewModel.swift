//
//  PlanViewModel.swift
//  Stardust
//
//  Created by sueun kim on 6/4/24.
//

import SwiftUI
import Alamofire

struct RequestModel: Codable {
    let PlanTitle: String
    let PlanDetail: [String]
    let PlanAttainment: [Bool]
    let Date: String
}
struct ResponseModel: Codable{
    let id: String
}

class PlanViewModel: ObservableObject{
    @Published var plans: [Plan] = []
    @Published var ToDo: RequestModel? = nil
    let localURL: String = "http://localhost:12341"
    init(){
        self.requestGet()
    }
    func addPlan(_ title: String, _ messages: [String], _ date: String){
        let url = "\(localURL)/add"
        let parameter: Parameters? = [
            "PlanTitle": title,
            "PlanDetail": messages,
            "PlanAttainment": [false],
            "Date": date
        ]
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: ResponseModel.self){ response in
            switch response.result{
            case .success(let data):
                print(data.id)
            case .failure(let fail):
                print(fail.localizedDescription)
            }
        }
    }
    func requestGet(){
        let url = "\(localURL)/get/e9e89f34-3fbd-44c6-954c-4abdfd5b7ee6"
        AF.request(url, method: .get).responseDecodable(of: RequestModel.self) { response in
            switch response.result{
            case .success(let success):
                print(success.PlanTitle)
                self.ToDo = success
            case .failure(let fail):
                print(fail.localizedDescription)
            }
        }
    }
}
