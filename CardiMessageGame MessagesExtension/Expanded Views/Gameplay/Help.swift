//
//  Help.swift
//  iMessage Playground
//
//  Created by Carter Hawkins on 12/25/23.
//

import SwiftUI

struct Help: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .foregroundColor(.white)
                
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .scaledToFit()
                    .padding(geo.size.height / 10)
                    .foregroundColor(.black)
                
            }
        }
    }
}
