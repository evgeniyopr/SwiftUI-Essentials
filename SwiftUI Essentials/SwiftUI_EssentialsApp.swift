//
//  SwiftUI_EssentialsApp.swift
//  SwiftUI Essentials
//
//  Created by Evgeniy Opryshko on 14.04.2022.
//

import SwiftUI

@main
struct SwiftUI_EssentialsApp: App {
    @StateObject private var modelData = ModelData()
    
    let persistenceController = PersistenceController.shared
    
    
    @Environment(\.scenePhase) var scenePhase

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(modelData)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
            
            .onChange(of: scenePhase) { newScenePhase in
                switch newScenePhase {
                    
                case .background:
                    persistenceController.save { _ in }
                    print("Scene is in background")
                case .inactive:
                    print("Scene is in inactive")
                case .active:
                    print("Scene is in active")
                @unknown default:
                    print("Scene is in unknown")
                }
            }
        }
}
