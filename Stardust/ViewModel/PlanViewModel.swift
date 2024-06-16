//
//  PlanViewModel.swift
//  Stardust
//
//  Created by sueun kim on 6/4/24.
//
import SwiftUI
import Alamofire

struct RequestModel: Codable,Identifiable {
    let id = UUID()
    let PlanTitle: String
    let PlanDetail: [String]
    let PlanAttainment: [Bool]
    let Date: String
}
protocol SetGoal{
    func createPlanId()
    func requestPlans()
    func addPlan(_ title: String, _ messages: [String], _ date: String)
}

struct ResponseModel: Codable{
    let id: String
}

class PlanViewModel: ObservableObject, SetGoal{
    @Published var plans: [Plan] = []
    @Published var ToDo: [RequestModel] = []
    let localURL: String = "http://localhost:12341"
    init(){
        if let planId = UserDefaults.standard.string(forKey: "planID"){
            return
        }else{
            self.createPlanId()
        }
    }
    func createPlanId(){
        let url = "\(localURL)/create"
        AF.request(url,method: .post).responseDecodable(of: ResponseModel.self) { response in
            switch response.result{
            case .success(let data):
                print("table id : \(data.id)")
                self.saveId(data.id)
            case .failure(let createError):
                print("\(createError.localizedDescription)")
            }
        }
    }
    func addPlan(_ title: String, _ messages: [String], _ date: String){
        guard let planID = UserDefaults.standard.string(forKey: "planID") else{
            return
        }
        let url = "\(localURL)/add/\(planID)"
        let parameter: Parameters? = [
            "PlanTitle": title,
            "PlanDetail": messages,
            "PlanAttainment": [false],
            "Date": date
        ]
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).response{ response in
            switch response.result{
            case .success(let data):
                print(data)
            case .failure(let fail):
                print(fail.localizedDescription)
            }
        }
    }
    func requestPlans(){
        guard let planID = UserDefaults.standard.string(forKey: "planID") else{
           return
        }
        let url = "\(localURL)/get/\(planID)"
        AF.request(url, method: .get).responseDecodable(of: [RequestModel].self) { response in
            switch response.result{
            case .success(let success):
                self.ToDo = success
            case .failure(let fail):
                print(fail.localizedDescription)
            }
        }
    }
    func saveId(_ saveIdString: String){
       UserDefaults.standard.setValue(saveIdString, forKey: "planID")
    }
    func clearUserDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        for key in dictionary.keys {
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
}
