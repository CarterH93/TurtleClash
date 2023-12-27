//
//  Game:Round win logic.swift
//  CardiMessageGame MessagesExtension
//
//  Created by Carter Hawkins on 12/25/23.
//

import SwiftUI
import UIKit
import Messages
import Combine


extension MessagesViewController {
    
    func checkForRoundWin() {
        
        if let localPlayerSelection = storage.localPlayerSelection {
            
            
            
            if let remotePlayerSelection = storage.remotePlayerSelection {
                
                
                
                //Set Current Round Result to display for user
                if localPlayerSelection.typeNum == 1 && remotePlayerSelection.typeNum == 1 {
                    
                    //Note it is impossible for a card to have both the same type and number.
                    if localPlayerSelection.number > remotePlayerSelection.number {
                        storage.tempPastRoundResult = 1
                        storage.pastRoundResultSide = storage.currentPlayer
                    } else {
                        storage.tempPastRoundResult = 2
                        storage.pastRoundResultSide = storage.currentPlayer
                    }
                    
                } else if localPlayerSelection.typeNum == 1 && remotePlayerSelection.typeNum == 2 {
                    storage.tempPastRoundResult = 2
                    storage.pastRoundResultSide = storage.currentPlayer
                } else if localPlayerSelection.typeNum == 1 && remotePlayerSelection.typeNum == 3 {
                    storage.tempPastRoundResult = 1
                    storage.pastRoundResultSide = storage.currentPlayer
                } else if localPlayerSelection.typeNum == 2 && remotePlayerSelection.typeNum == 1 {
                    storage.tempPastRoundResult = 1
                    storage.pastRoundResultSide = storage.currentPlayer
                } else if localPlayerSelection.typeNum == 2 && remotePlayerSelection.typeNum == 2 {
                    //Note it is impossible for a card to have both the same type and number.
                    if localPlayerSelection.number > remotePlayerSelection.number {
                        storage.tempPastRoundResult = 1
                        storage.pastRoundResultSide = storage.currentPlayer
                    } else {
                        storage.tempPastRoundResult = 2
                        storage.pastRoundResultSide = storage.currentPlayer
                    }
                } else if localPlayerSelection.typeNum == 2 && remotePlayerSelection.typeNum == 3 {
                    storage.tempPastRoundResult = 2
                    storage.pastRoundResultSide = storage.currentPlayer
                } else if localPlayerSelection.typeNum == 3 && remotePlayerSelection.typeNum == 1 {
                    storage.tempPastRoundResult = 2
                    storage.pastRoundResultSide = storage.currentPlayer
                } else if localPlayerSelection.typeNum == 3 && remotePlayerSelection.typeNum == 2 {
                    storage.tempPastRoundResult = 1
                    storage.pastRoundResultSide = storage.currentPlayer
                } else if localPlayerSelection.typeNum == 3 && remotePlayerSelection.typeNum == 3 {
                    //Note it is impossible for a card to have both the same type and number.
                    if localPlayerSelection.number > remotePlayerSelection.number {
                        storage.tempPastRoundResult = 1
                        storage.pastRoundResultSide = storage.currentPlayer
                    } else {
                        storage.tempPastRoundResult = 2
                        storage.pastRoundResultSide = storage.currentPlayer
                    }
                }
                
                
                //Stores Results
                
                if storage.pastRoundResult == 1 {
                    //Player 1 won the round
                    
                    storage.winningSelectionsPlayer1.append(storage.player1Selection!)
                } else if storage.pastRoundResult == 2 {
                    //Player 2 won the round
                    
                    storage.winningSelectionsPlayer2.append(storage.player2Selection!)
                } else {
                    // there is a tie
                    
                    
                    //Do nothing
                }
                
                //Stores selection data
                storage.pastRoundselectionPlayer1 = storage.player1Selection
                storage.pastRoundselectionPlayer2 = storage.player2Selection
                
                //Clear current Data
                
                storage.player1Selection = nil
                storage.player2Selection = nil
                
                
                
            }
            
        }
    }

    
    func checkForWin() {
        
        if storage.winningSelectionsPlayer1.count == 3 {
            storage.overallGameEndingResult = 1
        } else if storage.winningSelectionsPlayer2.count == 3 {
            storage.overallGameEndingResult = 2
        }
        
    }
    
    
    
}
