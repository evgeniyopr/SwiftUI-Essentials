//
//  TestLoadView.swift
//  SwiftUI Essentials
//
//  Created by Evgeniy Opryshko on 15.04.2022.
//

import SwiftUI

struct TestLoadView: View {
    
    @Environment(\.dismiss) var dismiss
        
    private let smallSample = "https://www.learningcontainer.com/wp-content/uploads/2020/07/Sample-JPEG-Image-File-Download-scaled.jpg"
    private let mediumSample = "https://www.learningcontainer.com/wp-content/uploads/2020/07/Sample-JPEG-Image-File-Download.jpg"
    private let largeSample = "https://www.learningcontainer.com/wp-content/uploads/2020/07/Sample-Image-file-Download.jpg"
    private let extraLarge = "https://www.learningcontainer.com/wp-content/uploads/2020/07/Large-Sample-Image-download-for-Testing.jpg"
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: smallSample)!) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
            AsyncImage(url: URL(string: mediumSample)!) { image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
            AsyncImage(url: URL(string: largeSample)!) { image in
                image.resizable()
            } placeholder: {
                Text("")
                    .overlay(ProgressView()
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .opacity(1))
            }
            .frame(width: 130, height: 130)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
            AsyncImage(url: URL(string: largeSample)!, scale: 1, transaction: Transaction(animation: .spring())) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(_):
                    Image(systemName: "exclamationmark.icloud")
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    Image(systemName: "exclamationmark.icloud")
                }
            }
            .frame(width: 140, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
            Spacer()
            
            Button("Cancel") {
                dismiss()
            }
        
            .padding(50)
            .buttonStyle(BorderedButtonStyle())
        }
    }
}

struct TestLoadView_Previews: PreviewProvider {
    static var previews: some View {
        TestLoadView()
    }
}
