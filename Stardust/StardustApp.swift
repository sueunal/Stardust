//
//  StardustApp.swift
//  Stardust
//
//  Created by sueun kim on 5/29/24.
//

import SwiftUI
import CoreData

@main
struct StardustApp: App {
    @StateObject private var dataController: DataController = DataController()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
