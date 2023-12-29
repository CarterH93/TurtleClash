//
//  WinningStack.swift
//  iMessage Playground
//
//  Created by Carter Hawkins on 12/25/23.
//

import SwiftUI

struct WinningStack: View {
    var icon: String
    var color1: Color?
    var color2: Color?
    var color3: Color?
    
    var body: some View {
        GeometryReader { geo in
           
                VStack(spacing: 0) {
                    
                    if let color = color1 {
                        ZStack {
                            Color(.init(color))
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .padding(geo.size.height * 0.04)
                        }
                        .frame(height: geo.size.height * 0.623)
                    }
                   
                    if let color = color2 {
                        Color(.init(color))
                            .frame(height: geo.size.height * 0.187)
                    }
                    if let color = color3 {
                        Color(.init(color))
                            .frame(height: geo.size.height * 0.19)
                    }
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: geo.size.height / 12))
               
                
                
            
            
            
            
        }
    }
}

