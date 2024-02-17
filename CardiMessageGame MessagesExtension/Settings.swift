//
//  Settings.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//


import SwiftUI

struct Settings: View {
    @EnvironmentObject var storage: AppStorage
    
    var body: some View {
        ZStack {
            ScrollView {
              
                Text("Settings")
                    .font(.largeTitle)
                    .padding()
                
                Text("Game Settings")
                    .font(.headline)
                    .padding()
                
                Toggle("Play Background Music", isOn: $storage.playBackgroundMusic)
                    .padding()
                
                Toggle("Play Sound Effects", isOn: $storage.playSoundEffects)
                    .padding()
                
                Text("Resources")
                    .font(.headline)
                    .padding()
                
                Link(destination: URL(string: "https://www.carterapps.net")!) {
                    Image(systemName: "link.circle.fill")
                        .font(.largeTitle)
                    Text("Website")
                        .foregroundStyle(.primary)
                }
                .padding([.top, .trailing, .leading])
                
                Link(destination: URL(string: "https://www.carterapps.net")!) {
                    Image(systemName: "info.circle.fill")
                        .font(.largeTitle)
                    Text("Privacy Policy")
                        .foregroundStyle(.primary)
                }
                .padding([.top, .trailing, .leading])
                
            }
            VStack {
                HStack {
                 Spacer()
                    Button {
                        storage.settingsMenuActive = false
                        storage.goToCompactView = true
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .scaledToFit()
                                .padding(5)
                                .foregroundColor(.black)
                                
                            
                        }
                        .frame(width: 50, height: 50)
                        .padding(10)
                    }
                    
                    
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "nil")")
                        .padding()
                }
            }
        }
    }
   
}







/*
 @EnvironmentObject var storage: AppStorage
 var body: some View {
     VStack {
         Text("Settings!!!")
         Button("dismiss") {
             storage.settingsMenuActive = false
             storage.goToCompactView = true
         }
     }
 }
 */
