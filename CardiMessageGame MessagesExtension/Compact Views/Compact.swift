//
//  Compact.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//


import SwiftUI

struct Compact: View {
    
    @EnvironmentObject var storage: AppStorage
   
    var body: some View {

            ZStack {
                
                
                        
                
                
                
                VStack(spacing: 20) {
                    Text("Turtle Clash")
                        .font(.largeTitle.bold())
                    
                    Image("title")
                        .resizable()
                        .scaledToFit()
                        .padding([.leading,.trailing], 40)
                        .padding([.bottom,.top])
                    
                    Button("New Game") {
                        storage.newGame.toggle()
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                }
                .padding()
                .padding(.bottom)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            storage.settingsMenuActive = true
                            storage.goToExpnadedView = true
                        } label: {
                            ZStack {
                                Image(systemName: "gear")
                                    .resizable()
                                    .scaledToFit()
                                    
                                    
                                    
                                
                            }
                            .frame(width: 40)
                            .padding(30)
                        }
                        .buttonStyle(.plain)
                    }
                    Spacer()
                }
                
                
                
            }
            .ignoresSafeArea()
           
        
        
        .onAppear {
            storage.settingsMenuActive = false
        }
        
    }
        
}
