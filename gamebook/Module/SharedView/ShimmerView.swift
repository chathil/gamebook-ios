//
//  ShimmerView.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/14/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct ShimmerView: View {
    
    private struct Constants {
        static let duration: Double = 0.9
        static let minOpacity: Double = 0.5
        static let maxOpacity: Double = 0.9
    }
    let color: Color
    init(color: Color = Color("primary-black")) {
        self.color = color
    }
    @State private var opacity: Double = Constants.minOpacity
    
    var body: some View {
        Rectangle()
            .fill(color)
            .opacity(opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: Constants.duration)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = Constants.maxOpacity
                }
        }
    }
}
