//
//  PlanViewModel.swift
//  Stardust
//
//  Created by sueun kim on 6/4/24.
//

import SwiftUI
import Alamofire

class PlanViewModel: ObservableObject{
    @Published var plans: [Plan] = []
    let urlString: String = "https://665701489f970b3b36c78bd9.mockapi.io/plan"
    
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
