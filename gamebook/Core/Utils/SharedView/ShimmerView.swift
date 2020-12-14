//
//  ShimmerView.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/14/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct ShimmerView: View {
    @State private var opacity: Double = Constants.minOpacity
    let color: Color
    private struct Constants {
        static let duration: Double = 0.9
        static let minOpacity: Double = 0.5
        static let maxOpacity: Double = 0.9
    }
    
    init(color: Color = Color("primary-black")) {
        self.color = color
    }
    
    var body: some View {
        ZStack {
            Text("Loading Indicator").frame(width: 0, height: 0) // to identify this view in test. i know it's weird.
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
}
