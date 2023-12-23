//
//  Expanded.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//

import SwiftUI
//Information bridge to UIkit
//https://youtu.be/CNhcAz40Myw
//https://www.youtube.com/watch?v=Ent5zMwt-h4&t=0s

struct Expanded: View {
    
    
    @State private var size = 1.0
    @EnvironmentObject var storage: AppStorage
   
    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            VStack(spacing: 30) {
                
                ScrollView {
                    Text("Player 1 past selection: \(storage.pastRoundselectionPlayer1)")
                    Text("Player 2 past selection: \(storage.pastRoundselectionPlayer2)")
                    Text("Past Round Result: \(storage.pastRoundResult)")
                    Text("temp Past Round Result: \(storage.tempPastRoundResult)")
                    Text("Past Round Result Side: \(storage.pastRoundResultSide)")
                    Text("Player 1 selection: \(storage.player1Selection)")
                    Text("Player 2 selection: \(storage.player2Selection)")
                    Text("Player 1 wins:        \(storage.winningSelectionsPlayer1.description)")
                    Text("Player 2 wins:        \(storage.winningSelectionsPlayer2.description)")
                    Text("Current Player Turn :    \(storage.currentPlayerTurn)")
                    Text("Is it local player turn?  \(storage.localPlayerCurrentTurnTrue.description)")
                    Text("Participants")
                    Text("local: \(storage.localParticipantIdentifier) END")
                    Text("Sender: \(storage.SenderParticipantIdentifier) END")
                    Text("Player1: \(storage.player1)")
                    Text("Player2: \(storage.player2)")
                    Text("All IDs in conversation: \(AppStorage.convertToList(Array(storage.participantsInConversasion))) END")
                    Text("Current Player: \(storage.currentPlayer)")
                    Text("Logged participants: \(storage.participantsInConversasion.count)")
                
                   
                    
                }
                
                
                /*
            VStack(spacing: 20) {
                    Text("Send Message Text")
                    TextField("Send Message Text", text: $storage.name)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.accentColor)
                
            }
            .padding()
                 */
                VStack {
                    if storage.pastRoundResult != 0 {
                        Text("Past Round Result")
                    }
                    
                    if storage.pastLocalPlayerSelection != 0 {
                        Text("You chose \(storage.selectionDescription(storage.pastLocalPlayerSelection))")
                    }
                    
                    if storage.pastRemotePlayerSelection != 0 {
                        Text("Your opponent chose \(storage.selectionDescription(storage.pastRemotePlayerSelection))")
                    }
                    
                    //Displays current round results
                    if storage.pastRoundResult == 1 {
                        Text("You won the round:  \(storage.selectionDescription(storage.pastLocalPlayerSelection)) beats \(storage.selectionDescription(storage.pastRemotePlayerSelection))")
                    } else if storage.pastRoundResult == 2 {
                        Text("You lost the round:  \(storage.selectionDescription(storage.pastRemotePlayerSelection)) beats \(storage.selectionDescription(storage.pastLocalPlayerSelection))")
                    } else if storage.pastRoundResult == 3 {
                        Text("Tie!!! You both chose  \(storage.selectionDescription(storage.pastLocalPlayerSelection))")
                    }
                    
                    //Displays overall game results
                    
                    if storage.didLocalPlayerWinOverall == 1 {
                        Text("Congrats you won the game")
                    } else if storage.didLocalPlayerWinOverall == 2 {
                        Text("You lost the game")
                    }
                    
                   
                    
                    
                    
                }
                
               
                
                
                VStack(spacing: 20) {
                    if storage.localPlayerSelection == 0 {
                        Text("Select your choice")
                    } else {
                        Text("You selected \(storage.selectionDescription(storage.localPlayerSelection))")
                    }
                    
                    
                    
                    
                    HStack {
                        Button("🪨") {
                            storage.selectChoice(1)
                        }
                        Button("📄") {
                            storage.selectChoice(2)
                        }
                        
                        Button("✂️") {
                            storage.selectChoice(3)
                        }
                    }
                    
                }
                .padding()
            .padding()
    
            
            
            //Sets variable
        
            Button {
                storage.send.toggle()
                
            } label: {
                Text("Send Message")
                    .padding()
                  .background(.regularMaterial)
            }
            
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .disabled(storage.goodToSend == true ? false : true)
            
            
            
           
            
            Image("France")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .scaleEffect(size)
                    .onTapGesture {
                        withAnimation {
                            if size > 1 {
                                size = 1
                            } else {
                                size += 1
                            }
                        }
                    }
            
                Button("Settings") {
                    storage.settingsMenuActive = true
                }
        }
    }
    }
}


//The previews for SwiftUI are not supported


