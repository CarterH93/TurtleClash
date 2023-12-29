//
//  BackCardView.swift
//  iMessage Playground
//
//  Created by Carter Hawkins on 12/25/23.
//

import SwiftUI

struct BackCardView: View {
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Blue1"), Color("Blue2")]), startPoint: .bottomLeading, endPoint: .topTrailing)
            }
            .clipShape(RoundedRectangle(cornerRadius: geo.size.height / 12))
            .overlay(
                RoundedRectangle(cornerRadius: geo.size.height / 12)
                    .stroke(.white, lineWidth: geo.size.height / 25)
            )
            
            
            
            
        }
    }
}

