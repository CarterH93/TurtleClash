//
//  Storage.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//


import SwiftUI

class AppStorage: ObservableObject {
    
    @Published var goToCompactView = false
    @Published var goToExpnadedView = false
    
    
    
    
    @Published var messageDataExists = false
    @Published var settingsMenuActive = false
    
    
    //Main player Logic
    @Published var player1 = ""
    @Published var player2 = ""
    
   
    
    //Main storage of participants in imessage app
    @Published var participantsInConversasion = Set<String>()
    
    @Published var maxPlayers = 2
    
    
    @Published var send: Bool = false
    @Published var newGame: Bool = false
 
    
    //Player Turn
    //Identifies the current players turn (Used for Game Logic)
    @Published var currentPlayerTurn: Int = 0
    
    //Determine if it is the local players turn
    
    var localPlayerCurrentTurnTrue: Bool {
        if currentPlayer == currentPlayerTurn {
            return true
        } else {
            return false
        }
    }
    
    //Can compare these two values for max player count and whos turn it is in a game.
    @Published var localParticipantIdentifier: String = "None"
    
    
    //WARNING
    //THIS INFORMATION CAN BE WRONG
    //USE CAUTION WITH THIS VALUE
    @Published var SenderParticipantIdentifier: String = "None"
    
    //THIS IS NOT THAT USEFUL
    //This list every single person in group chat regardless of whether they have interacted with the message
    //DO NOT USE THIS
    @Published var remoteParticipantIdentifiers: [String] = []
    
    
    //Identifies the if the local player is player 1 or 2
    var currentPlayer: Int {
        if localParticipantIdentifier == player1 {
            return 1
        } else if localParticipantIdentifier == player2 {
            return 2
        } else {
            if player1.isEmpty == true {
                return 1
            } else if player2.isEmpty == true {
                return 2
            } else {
                return 0
            }
        }
    }
    
    
    
    //Logic to know if to allow user to click send button
    
    var goodToSend: Bool {
        if overallGameEndingResult == 0 {
            if localPlayerSelection != nil {
                return true
            }
        }
        return false
    }
    
    
    //Can delete later
    //Just currently for testing purposes
    static func convertToList(_ list: [String]) -> String {
        var temp = ""
        for item in list {
            temp = temp + "   " + item
        }
        return temp
    }
    
    
    
    
    
    
    //Game logic for rock paper scissors game
    @Published var player1Selection: Card? = nil
    @Published var player2Selection: Card? = nil
    var localPlayerSelection: Card? {
        if currentPlayer == 1 {
            return player1Selection
        } else {
            return player2Selection
        }
    }
    
    var remotePlayerSelection: Card? {
        if currentPlayer == 2 {
            return player1Selection
        } else {
            return player2Selection
        }
    }
    
    
    var pastLocalPlayerSelection: Card? {
        if currentPlayer == 1 {
            return pastRoundselectionPlayer1
        } else {
            return pastRoundselectionPlayer2
        }
    }
    
    var pastRemotePlayerSelection: Card? {
        if currentPlayer == 2 {
            return pastRoundselectionPlayer1
        } else {
            return pastRoundselectionPlayer2
        }
    }
    /*
    func selectionDescription(_ input: Int) -> String {
        if input == 1 {
            return "Fire"
        } else if input == 2 {
            return "Water"
        } else if input == 3 {
            return "Ice"
        } else {
            return "ERROR"
        }
    }
    
    */
   
    
    @Published var winningSelectionsPlayer1: [Card] = []
    @Published var winningSelectionsPlayer2: [Card] = []
    
    
    //Converting stuff inorder to send through iMessage Data Kit API
    
    var winningSelectionsPlayer1TypeConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in winningSelectionsPlayer1 {
            hold.append(i.typeNum)
        }
        
        return hold
    }
    
    var winningSelectionsPlayer1ColorConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in winningSelectionsPlayer1 {
            hold.append(i.colorNum)
        }
        
        return hold
    }
    
    var winningSelectionsPlayer1NumberConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in winningSelectionsPlayer1 {
            hold.append(i.number)
        }
        
        return hold
    }
    
    var winningSelectionsPlayer2TypeConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in winningSelectionsPlayer2 {
            hold.append(i.typeNum)
        }
        
        return hold
    }
    
    var winningSelectionsPlayer2ColorConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in winningSelectionsPlayer2 {
            hold.append(i.colorNum)
        }
        
        return hold
    }
    
    var winningSelectionsPlayer2NumberConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in winningSelectionsPlayer2 {
            hold.append(i.number)
        }
        
        return hold
    }
    
    
    @Published var name: String = ""
    
    
    @Published var pastRoundselectionPlayer1: Card? = nil
    @Published var pastRoundselectionPlayer2: Card? = nil
    
    
    var pastRoundResult: Int {
        if pastRoundResultSide == currentPlayer {
            return tempPastRoundResult
        } else {
            if tempPastRoundResult == 3 {
                return 3
            } else if tempPastRoundResult == 2 {
                return 1
            } else if tempPastRoundResult == 1 {
                return 2
            } else {
                return 0
            }
        }
    }
    
    @Published var tempPastRoundResult: Int = 0
    //0 = nil
    //1 = win
    //2 = lost
    //3 = tie
    @Published var pastRoundResultSide: Int = 0
        
    @Published var overallGameEndingResult: Int = 0
    
    var didLocalPlayerWinOverall: Int {
        if overallGameEndingResult == 1 {
            if currentPlayer == 1 {
                return 1
            } else {
                return 2
            }
        } else if overallGameEndingResult == 2 {
            if currentPlayer == 2 {
                return 1
            } else {
                return 2
            }
        } else {
            return 0
        }
    }
    
    //Assigns player choice to correct player variable
    func selectChoice(_ choice: Card) {
        if currentPlayer == 1 {
            player1Selection = choice
        } else if currentPlayer == 2 {
            player2Selection = choice
        }
    }
    
}


//Card logic handling

func cardCreator(number: Int, type: Int, color: Int) -> Card {
    /*
     numbers for type
    1 = fire
    2 = water
    3 = ice
     
     numbers for color
     1 = blue
     2 = orange
     3 = green
    */
    
    var newType: type
    var newColor: color
    
    switch type {
    case 1:
        newType = .fire
    case 2:
        newType = .water
    default:
        newType = .ice
    }
    
    switch color {
    case 1:
        newColor = .blue
    case 2:
        newColor = .orange
    default:
        newColor = .green
    }
    
    return Card(number: number, type: newType, color: newColor)
    
}
