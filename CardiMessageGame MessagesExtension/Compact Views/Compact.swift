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
        NavigationView {
            ZStack {
                
                    Color.orange
                        
                
                
                
                VStack(spacing: 20) {
                    Text("Imessage Game")
                        .font(.largeTitle)
                    
                    
                    
                    Button("Send Game") {
                        storage.newGame.toggle()
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                }
                
                
                
                
                
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Settings") {
                        storage.settingsMenuActive = true
                        storage.goToExpnadedView = true
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        
        .onAppear {
            storage.settingsMenuActive = false
        }
        
    }
        
}
