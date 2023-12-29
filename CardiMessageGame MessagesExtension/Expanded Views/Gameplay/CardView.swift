//
//  CardView.swift
//  iMessage Playground
//
//  Created by Carter Hawkins on 12/25/23.
//

import SwiftUI

struct CardView: View {
    
    var card: Card
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: geo.size.height / 12)
                    .foregroundColor(card.convertColorToRealColor)
                    
                Image("cardimage\(card.animation)")
                    .resizable()
                    .scaledToFit()
                    .padding(geo.size.height * 0.02)
                
                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: geo.size.height * 0.05)
                                .foregroundColor(.gray)
                            VStack {
                                Image(card.type.rawValue)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: geo.size.height * 0.2)
                                Text(String(card.number))
                                    .font(.system(size: geo.size.height * 0.15, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                            .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.5)
                    }
                    Spacer()
                }
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: geo.size.height / 12)
                    .stroke(.white, lineWidth: geo.size.height / 25)
            )
        }
    }
}

