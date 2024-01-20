//
//  WrappedExpanded.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//


import SwiftUI

struct WrappedExpanded: View {
    @EnvironmentObject var storage: AppStorage
    
    var body: some View {
        
        ZStack {
            
            Expanded()
                .disabled(storage.participantsInConversasion.count > storage.maxPlayers || storage.localPlayerCurrentTurnTrue == false || storage.gameover || storage.helpMenuVisable ? true : false)
                .blur( radius: storage.participantsInConversasion.count > storage.maxPlayers || storage.localPlayerCurrentTurnTrue == false || storage.gameover ? 2 : 0)
                //.brightness(storage.participantsInConversasion.count > storage.maxPlayers || storage.localPlayerCurrentTurnTrue == false || storage.gameover ? -0.5 : 0)
            
            
            if storage.participantsInConversasion.count > storage.maxPlayers {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.green)
                    VStack {
                        Text("Game Full")
                        Text("Max of Two Players Only!")
                        Button("Settings") {
                            storage.settingsMenuActive = true
                        }
                        
                    }
                    
                }
                .frame(width: 300, height: 200)
              
            } else if storage.gameover {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.green)
                        VStack {
                            Text("Game Over!")
                            if storage.didLocalPlayerWinOverall == 1 {
                                Text("You won")
                            } else {
                                Text("You lost")
                            }
                            Button("Settings") {
                                storage.settingsMenuActive = true
                            }
                            
                        }
                        
                    }
                    .frame(width: 300, height: 200)
                }
            } else if storage.localPlayerCurrentTurnTrue == false {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.green)
                        VStack {
                            Text("It is not your turn")
                            Text("Please wait for other player")
                            Button("Settings") {
                                storage.settingsMenuActive = true
                            }
                            
                        }
                        
                    }
                    .frame(width: 300, height: 200)
                }
                
                
            } else if storage.helpMenuVisable {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.gray)
                        VStack {
                            Text("Help Menu")
                            Text("Show directions")
                            Button("Exit") {
                                storage.helpMenuVisable = false
                            }
                            
                        }
                        
                    }
                    .frame(width: 300, height: 200)
                }
            }
        }
    }
}

