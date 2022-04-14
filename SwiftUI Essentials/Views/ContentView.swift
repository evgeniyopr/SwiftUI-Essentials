//
//  ContentView.swift
//  SwiftUI Essentials
//
//  Created by Evgeniy Opryshko on 14.04.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
