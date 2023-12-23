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
            if localPlayerSelection != 0 {
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
    @Published var player1Selection = 0
    @Published var player2Selection = 0
    var localPlayerSelection: Int {
        if currentPlayer == 1 {
            return player1Selection
        } else {
            return player2Selection
        }
    }
    
    var remotePlayerSelection: Int {
        if currentPlayer == 2 {
            return player1Selection
        } else {
            return player2Selection
        }
    }
    
    
    var pastLocalPlayerSelection: Int {
        if currentPlayer == 1 {
            return pastRoundselectionPlayer1
        } else {
            return pastRoundselectionPlayer2
        }
    }
    
    var pastRemotePlayerSelection: Int {
        if currentPlayer == 2 {
            return pastRoundselectionPlayer1
        } else {
            return pastRoundselectionPlayer2
        }
    }
    
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
    
    
   
    
    @Published var winningSelectionsPlayer1: [Int] = []
    @Published var winningSelectionsPlayer2: [Int] = []
    @Published var name: String = ""
    
    
    @Published var pastRoundselectionPlayer1 = 0
    @Published var pastRoundselectionPlayer2 = 0
    
    
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
    func selectChoice(_ choice: Int) {
        if currentPlayer == 1 {
            player1Selection = choice
        } else if currentPlayer == 2 {
            player2Selection = choice
        }
    }
    
}
