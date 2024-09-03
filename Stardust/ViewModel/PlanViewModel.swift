//
//  PlanViewModel.swift
//  Stardust
//
//  Created by sueun kim on 6/4/24.
//
import SwiftUI
import Observation


class NetworkManger{
    let endPoint: String = "http://localhost:12341"
    func connectToServer(completation: @escaping ([RequestModel])->())-> String{
        let url: String = "\(endPoint)/create"
        guard let url = URL(string: url) else{
            return ""
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
        return ""
    }
    func asyncTest() async throws -> [RequestModel]{
        guard let planID = UserDefaults.standard.string(forKey: "planID") else { return  []}
        guard let url  = URL(string: "\(endPoint)/get/\(planID)") else{
            return []
        }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            print("DEBUG Data: \(data)")
            print(response)
            let decodeData = try JSONDecoder().decode([RequestModel].self, from: data)
           return decodeData
        } catch{
            print("ERROR JSON:", error.localizedDescription)
            return []
        }
    }
}
extension NetworkManger{
    func fetchPlan(completation: @escaping (Result<[RequestModel], PlanAPIError>)->()){
        guard let planID = UserDefaults.standard.string(forKey: "planID") else { return }
        let url: String = "\(endPoint)/get/\(planID)"
        guard let url = URL(string: url) else{ return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error =  error {
                print("DEBUG: Network Fail \(error.localizedDescription)")
                completation(.failure(.unknownError(error: error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else{
                completation(.failure(.requestFailed(description: "Request failed")))
                return
            }
            guard httpResponse.statusCode == 200 else{
                completation(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            guard let data = data else{
                completation(.failure(.invaildData))
                return
            }
            do {
                let responseData = try JSONDecoder().decode([RequestModel].self, from: data)
                completation(.success(responseData))
            }catch{
                completation(.failure(.jsonParsingFailure))
            }
        }
        .resume()
    }
}

class PlanViewModel: ObservableObject{
    @Published var plans: [Plan] = []
    @Published var toDo: [RequestModel] = []
    @Published var errorMessage: String? = ""
    private let networkManager = NetworkManger()
    
    init(){
        Task{
            try await ays()
        }
    }
    func ays() async throws{
        do{
            let toDos = try await networkManager.asyncTest()
            self.toDo = toDos
        }catch{
            print("\(error.localizedDescription)")
        }
    }
    func createPlanId() {
        networkManager.connectToServer { requestData in
            self.toDo = requestData
        }
    }
    func addPlan(_ title: String, _ messages: [String], _ date: String){
        guard let planID = UserDefaults.standard.string(forKey: "planID") else{
            return
        }
    }
    func requestPlans(){
        networkManager.fetchPlan { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let plans):
                    self?.toDo = plans
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
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
