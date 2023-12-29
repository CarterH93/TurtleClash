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
    
    @State private var type: type = .fire
    @State private var color: color = .blue
    @State private var number = 1
    @State private var animation = 1
   
    var body: some View {
        
        ZStack {
            Color.orange
                .ignoresSafeArea()
            VStack(spacing: 30) {
                
                ScrollView {
                    
                     
                    Text("Player 1 past selection: \(storage.pastRoundselectionPlayer1?.description ?? "Nil")")
                    Text("Player 2 past selection: \(storage.pastRoundselectionPlayer2?.description ?? "Nil")")
                    Text("Past Round Result: \(storage.pastRoundResult)")
                    Text("temp Past Round Result: \(storage.tempPastRoundResult)")
                    Text("Past Round Result Side: \(storage.pastRoundResultSide)")
                    Text("Player 1 selection: \(storage.player1Selection?.description ?? "Nil")")
                    Text("Player 2 selection: \(storage.player2Selection?.description ?? "Nil")")
                    Text("Player 1 wins:        \(storage.winningSelectionsPlayer1.count)")
                    Text("Player 2 wins:        \(storage.winningSelectionsPlayer2.count)")
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
                    
                    if storage.pastLocalPlayerSelection != nil {
                        Text("You chose \(storage.pastLocalPlayerSelection?.description ?? "Nil")")
                    }
                    
                    if storage.pastRemotePlayerSelection != nil {
                        Text("Your opponent chose \(storage.pastRemotePlayerSelection?.description ?? "Nil")")
                    }
                    
                    //Displays current round results
                    if storage.pastRoundResult == 1 {
                        Text("You won the round:  \(storage.pastLocalPlayerSelection?.description ?? "Nil") beats \(storage.pastRemotePlayerSelection?.description ?? "Nil")")
                    } else if storage.pastRoundResult == 2 {
                        Text("You lost the round:  \(storage.pastRemotePlayerSelection?.description ?? "Nil") beats \(storage.pastLocalPlayerSelection?.description ?? "Nil")")
                    } else if storage.pastRoundResult == 3 {
                        Text("Tie!!! You both chose  \(storage.pastLocalPlayerSelection?.description ?? "Nil")")
                    }
                    
                    //Displays overall game results
                    
                    if storage.didLocalPlayerWinOverall == 1 {
                        Text("Congrats you won the game")
                    } else if storage.didLocalPlayerWinOverall == 2 {
                        Text("You lost the game")
                    }
                    
                   
                    
                    
                    
                }
                
               
                
                
                VStack(spacing: 20) {
                    if storage.localPlayerSelection == nil {
                        Text("Select your choice")
                    } else {
                        Text("You selected \(storage.localPlayerSelection!.description)")
                    }
                    
                    
                    //Type selector
                    
                    HStack {
                         
                        Button("🔥") {
                            type = .fire
                        }
                        Button("💧") {
                            type = .water
                        }
                        
                        Button("🧊") {
                            type = .ice
                        }
                    }
                    
                    HStack {
                         
                        Button("🔵") {
                            color = .blue
                        }
                        Button("🟠") {
                            color = .orange
                        }
                        
                        Button("🟢") {
                            color = .green
                        }
                    }
                    
                    
                    Stepper("Number: \(number)", value: $number, in: 1...12)
                    
                    
                    Stepper("Animation: \(animation)", value: $animation, in: 1...12)
                    
                    Button("Create card") {
                        storage.selectChoice(Card(number: number, type: type, color: color, animation: animation))
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
    
    
  //  Gameplay()
    
    }
}


//The previews for SwiftUI are not supported


