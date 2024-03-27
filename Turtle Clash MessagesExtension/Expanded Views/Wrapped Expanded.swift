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
                        .strokeBorder(.white, lineWidth: 8)
                        .background(RoundedRectangle(cornerRadius: 20).fill(.green))
                    VStack {
                        Text("Game Full")
                            .padding(.bottom)
                        Text("Max of Two Players Only!")
                        
                        
                    }.foregroundColor(.white)
                        .font(.title3)
                    
                }
                .frame(width: 300, height: 200)
              
            } else if storage.gameover {
                VStack {
                    Spacer()
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(.white, lineWidth: 8)
                            .background(RoundedRectangle(cornerRadius: 20).fill(storage.didLocalPlayerWinOverall == 1 ? .green : .red))
                            
                        
                        VStack {
                            if storage.didLocalPlayerWinOverall == 1 {
                                Text("You won!!")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.black)
                            } else {
                                Text("You lost")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                            }
                            
                            
                        }
                        
                    }
                    .frame(width: 200, height: 100)
                    Spacer()
                }
            } else if storage.localPlayerCurrentTurnTrue == false {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(.white, lineWidth: 8)
                            .background(RoundedRectangle(cornerRadius: 20).fill(.green))
                        VStack {
                            Text("It is not your turn")
                                .padding(.bottom)
                            Text("Please wait for other player")
                            
                            
                        }.foregroundColor(.white)
                            .font(.title3)
                        
                    }
                    .frame(width: 300, height: 200)
                }
                
                
            } else if storage.helpMenuVisable {
                HelpMenu()
            }
        }
    }
}

