//
//  TestLoadView.swift
//  SwiftUI Essentials
//
//  Created by Evgeniy Opryshko on 15.04.2022.
//

import SwiftUI

struct TestLoadOldView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let largeSample = "https://www.learningcontainer.com/wp-content/uploads/2020/07/Sample-Image-file-Download.jpg"
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            AsyncImageLoading(
                url: URL(string: largeSample)!,
                placeholder: { ProgressView() },
                image: { Image(uiImage: $0).resizable() }
            ).frame(width: 200, height: 200)
            
            ForEach(0..<10) { index in
                URLImage(urlString: largeSample)
                    .frame(width: 200, height: 200)
            }
            
            Spacer()
            
            Button("Cancel") {
                dismiss()
            }
            .padding(50)
            .buttonStyle(BorderedButtonStyle())
        }
    }
}

struct TestLoadOldView_Previews: PreviewProvider {
    static var previews: some View {
        TestLoadOldView()
    }
}
