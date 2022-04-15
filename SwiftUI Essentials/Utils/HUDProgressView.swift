//
//  HUDProgressView.swift
//  SwiftUI Essentials
//
//  Created by Evgeniy Opryshko on 14.04.2022.
//

import SwiftUI

struct HUDProgressView: View {
    
    var placeHolder: String
    
    @Binding var show: Bool
    @State var animate = false

    var body: some View {
        
        VStack(spacing: 28) {
            Circle()
                .stroke(AngularGradient(gradient: .init(colors: [Color.primary, Color.primary.opacity(0)]),
                                        center: .center))
                .frame(width: 80, height: 80)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
            Text(placeHolder)
                .font(.body)
            
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 35)
        .background(BlurView())
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35)
                .onTapGesture {
                    withAnimation {
                        show.toggle()
                    }
                }
            
        )
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                animate.toggle()
            }
        }
        
        
    }
    
    
    
}



