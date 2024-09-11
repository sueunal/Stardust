//
//  DataController.swift
//  Stardust
//
//  Created by Soom on 9/11/24.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Plan")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Core Data failed to load \(error.localizedDescription)")
            }
        }
    }
}
