//
//  CardView.swift
//  iMessage Playground
//
//  Created by Carter Hawkins on 12/25/23.
//

import SwiftUI

struct EmptyCard: View {
    
  
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: geo.size.height / 12)
                    .opacity(0)
                    
                    
                Text("Please Select a Card")
                    .font(.system(size: geo.size.height * 0.05, weight: .bold))
                    .padding(geo.size.height * 0.02)
                    .foregroundColor(.white.opacity(0.5))
                
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: geo.size.height / 12)
                    .stroke(.white.opacity(0.5), style: StrokeStyle(lineWidth: geo.size.height / 60, dash: [geo.size.height / 10]))
                   
            )
        }
    }
}

