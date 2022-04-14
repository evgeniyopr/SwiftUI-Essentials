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

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(modelData)
            }
        }
}
