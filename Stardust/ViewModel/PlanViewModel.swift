//
//  PlanViewModel.swift
//  Stardust
//
//  Created by sueun kim on 6/4/24.
//
import SwiftUI
import Observation
import Alamofire

protocol SetGoal{
    func createPlanId()
    func requestPlans()
    func addPlan(_ title: String, _ messages: [String], _ date: String)
}

enum Network{
    case success
    case fail(NetworkError)
}
enum NetworkError: String ,Error{
    case couldNotConnectServer = "서버에 연결할 수 없습니다.\n네트워크 연결을 확인해주세요"
}
class NetworkManger{
    let endPoint: String = "http://localhost:12341"
    func connectToServer(completation: @escaping ([RequestModel])->()){
        let url: String = "\(endPoint)/create"
        guard let url = URL(string: url) else{
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else{
                    return
            }
            do {
                let responseData = try JSONDecoder().decode([RequestModel].self, from: data)
                completation(responseData)
            }catch{
                print("Network Erorr: \(error.localizedDescription)")
            }
        }
        .resume()
    }
    func fetchPlan(completation: @escaping (Result<[RequestModel],Error>)->()){
        guard let planID = UserDefaults.standard.string(forKey: "planID") else { return }
        let url: String = "\(endPoint)/get/\(planID)"
        guard let url = URL(string: url) else{ return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error =  error {
                completation(.failure(error))
                print("DEBUG: Network Fail \(error.localizedDescription)")
                return
            }
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else{
                    return
            }
            do {
                let responseData = try JSONDecoder().decode([RequestModel].self, from: data)
                completation(.success(responseData))
            }catch{
                print("Network Erorr: \(error.localizedDescription)")
            }
        }
        .resume()
    }
}

@Observable
class PlanViewModel{
    var plans: [Plan] = []
    var toDo: [RequestModel] = []
    var errorMessage: String? = ""
    private let networkManager = NetworkManger()
   
    func createPlanId() {
        networkManager.connectToServer { requestData in
            self.toDo = requestData
        }
    }
    func addPlan(_ title: String, _ messages: [String], _ date: String){
        guard let planID = UserDefaults.standard.string(forKey: "planID") else{
            return
        }
//        let parameter: Parameters? = [
//            "PlanTitle": title,
//            "PlanDetail": messages,
//            "PlanAttainment": [false],
//            "Date": date
//        ]
//        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).response{ response in
//            switch response.result{
//            case .success(let data):
//                print(data)
//            case .failure(let fail):
//                print(fail.localizedDescription)
//            }
//        }
    }
    func requestPlans(){
        networkManager.fetchPlan { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let plans):
                    self.toDo = plans
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
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
