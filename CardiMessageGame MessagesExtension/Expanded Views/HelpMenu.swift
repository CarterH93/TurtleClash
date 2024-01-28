//
//  HelpMenu.swift
//  iMessage Playground
//
//  Created by Carter Hawkins on 1/27/24.
//

import SwiftUI

struct HelpMenu: View {
    
    @EnvironmentObject var storage: AppStorage
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                storage.helpMenuVisable = false
                                
                            }
                        }, label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(geo.size.width * 0.02)
                                    .foregroundColor(.black)
                                    
                                
                            }
                            .frame(width: geo.size.width * 0.12)
                            .padding(geo.size.width * 0.03)
                        })
                        
                    }
                    Spacer()
                }
                VStack {
                    HStack {
                        Text("Help")
                            .font(.title.bold())
                            .padding()
                    }
                    Text("How to win the round")
                        .font(.title2)
                    Image("roundWin")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Text("If tied, highest card number wins")
                        .font(.caption)
                        .padding(.bottom)
                        .padding(.bottom)
                    Text("How to win overall")
                        .font(.title2)
                    Image("overallWin1")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Text("Three different types with different colors")
                        .multilineTextAlignment(.center)
                        
                    Image("overallWin2")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Text("Three of the same type with different colors")
                        .multilineTextAlignment(.center)
                        
                        
                    
                }
                .foregroundColor(.black)
                .padding(.bottom)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(width: geo.size.width * 0.8, height: geo.size.width * 1.6)
            .frame(width: geo.size.width, height: geo.size.width)
            .frame(width: geo.size.width, height: geo.size.height)
        }
        
    }
}
