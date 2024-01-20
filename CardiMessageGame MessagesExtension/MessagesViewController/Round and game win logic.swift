//
//  Game:Round win logic.swift
//  CardiMessageGame MessagesExtension
//
//  Created by Carter Hawkins on 12/25/23.
//

import SwiftUI
import UIKit
import Combine



    



extension Gameplay {
    
    
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
                    
                    if storage.tempPastRoundResult == 1 {
                        
                        //Someone won the round
                        
                        if storage.pastRoundResultSide == 1 {
                            //player 1 won
                            
                            withAnimation(.snappy.delay(4)) {
                                storage.winningSelectionsPlayer1.append(storage.player1Selection!)
                            }
                        } else {
                            //player 2 won
                            withAnimation(.snappy.delay(4)) {
                                storage.winningSelectionsPlayer2.append(storage.player2Selection!)
                            }
                            
                        }
                        
                        
                        
                    } else if storage.tempPastRoundResult == 2 {
                        //Someone lost the round
                        
                        if storage.pastRoundResultSide == 1 {
                            //player 1 lost
                            withAnimation(.snappy.delay(4)) {
                                storage.winningSelectionsPlayer2.append(storage.player2Selection!)
                            }
                            
                        } else {
                            //player 2 lost
                            withAnimation(.snappy.delay(4)) {
                                storage.winningSelectionsPlayer1.append(storage.player1Selection!)
                            }
                            
                        }
                        
                       
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
        
       //First checking if there are three different colors of the same type
        
    //Checking local player first
        
        if storage.localPlayerWinningCardsDisplay[.fire]?.count == 3 {
            //WIN
            if storage.currentPlayer == 1 {
                storage.overallGameEndingResult = 1
            } else {
                storage.overallGameEndingResult = 2
            }
            
            storage.localPlayerWinningCardsAnimated[.fire] = storage.localPlayerWinningCardsDisplay[.fire]
            return
            
        } else if storage.localPlayerWinningCardsDisplay[.water]?.count == 3 {
            //WIN
            if storage.currentPlayer == 1 {
                storage.overallGameEndingResult = 1
            } else {
                storage.overallGameEndingResult = 2
            }
            
            storage.localPlayerWinningCardsAnimated[.water] = storage.localPlayerWinningCardsDisplay[.water]
            return
        } else if storage.localPlayerWinningCardsDisplay[.ice]?.count == 3 {
            //WIN
            if storage.currentPlayer == 1 {
                storage.overallGameEndingResult = 1
            } else {
                storage.overallGameEndingResult = 2
            }
            
            storage.localPlayerWinningCardsAnimated[.ice] = storage.localPlayerWinningCardsDisplay[.ice]
            return
        }
        
        //checking remote player
        
        if storage.remotePlayerWinningCardsDisplay[.fire]?.count == 3 {
            //WIN
            if storage.currentPlayer == 2 {
                storage.overallGameEndingResult = 1
            } else {
                storage.overallGameEndingResult = 2
            }
            
            storage.remotePlayerWinningCardsAnimated[.fire] = storage.remotePlayerWinningCardsDisplay[.fire]
            return
        } else if storage.remotePlayerWinningCardsDisplay[.water]?.count == 3 {
            //WIN
            if storage.currentPlayer == 2 {
                storage.overallGameEndingResult = 1
            } else {
                storage.overallGameEndingResult = 2
            }
            
            storage.remotePlayerWinningCardsAnimated[.water] = storage.remotePlayerWinningCardsDisplay[.water]
            return
        } else if storage.remotePlayerWinningCardsDisplay[.ice]?.count == 3 {
            //WIN
            if storage.currentPlayer == 2 {
                storage.overallGameEndingResult = 1
            } else {
                storage.overallGameEndingResult = 2
            }
            
            storage.remotePlayerWinningCardsAnimated[.ice] = storage.remotePlayerWinningCardsDisplay[.ice]
            return
            
        }
        
        
        //Checking if there are three different types that are each a unique color
        
        //This is for local player
        
        //Starting off with fire blue
        
        if let array = storage.localPlayerWinningCardsDisplay[.fire] {
            if array.contains(.blue) {
                //There is a blue fire
                
                var tempSet = Set<color>()
                
                if let array = storage.localPlayerWinningCardsDisplay[.water] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                if let array = storage.localPlayerWinningCardsDisplay[.ice] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                tempSet.remove(.blue)
                
                if tempSet.count >= 2 {
                    //WIN
                    if storage.currentPlayer == 1 {
                        storage.overallGameEndingResult = 1
                    } else {
                        storage.overallGameEndingResult = 2
                    }
                    
                    //Adding stuff to Animated
                    var tempAnimatedHold: [
                        type : [color]
                    ] = [:]
                    
                    tempAnimatedHold[.fire] = [.blue]
                    
                    for color in tempSet {
                        
                        if let array = storage.localPlayerWinningCardsDisplay[.water] {
                            
                            if array.contains(color) {
                                
                                tempAnimatedHold[.water] = [color]
                                
                                var tempTempSet = tempSet
                                tempTempSet.remove(color)
                        
                                tempAnimatedHold[.ice] = Array(tempTempSet)
                                
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    storage.localPlayerWinningCardsAnimated = tempAnimatedHold
                    
                    
                    
                }
            
            }
        }
        
        
        //Next is fire orange
        
        if let array = storage.localPlayerWinningCardsDisplay[.fire] {
            if array.contains(.orange) {
                //There is a orange fire
                
                var tempSet = Set<color>()
                
                if let array = storage.localPlayerWinningCardsDisplay[.water] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                if let array = storage.localPlayerWinningCardsDisplay[.ice] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                tempSet.remove(.orange)
                
                if tempSet.count >= 2 {
                    //WIN
                    if storage.currentPlayer == 1 {
                        storage.overallGameEndingResult = 1
                    } else {
                        storage.overallGameEndingResult = 2
                    }
                    
                    //Adding stuff to Animated
                    var tempAnimatedHold: [
                        type : [color]
                    ] = [:]
                    
                    tempAnimatedHold[.fire] = [.orange]
                    
                    for color in tempSet {
                        
                        if let array = storage.localPlayerWinningCardsDisplay[.water] {
                            
                            if array.contains(color) {
                                
                                tempAnimatedHold[.water] = [color]
                                
                                var tempTempSet = tempSet
                                tempTempSet.remove(color)
                        
                                tempAnimatedHold[.ice] = Array(tempTempSet)
                                
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    storage.localPlayerWinningCardsAnimated = tempAnimatedHold
                    
                }
            
            }
        }
        
        
        //Next is fire green
        
        if let array = storage.localPlayerWinningCardsDisplay[.fire] {
            if array.contains(.green) {
                //There is a green fire
                
                var tempSet = Set<color>()
                
                if let array = storage.localPlayerWinningCardsDisplay[.water] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                if let array = storage.localPlayerWinningCardsDisplay[.ice] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                tempSet.remove(.green)
                
                if tempSet.count >= 2 {
                    //WIN
                    if storage.currentPlayer == 1 {
                        storage.overallGameEndingResult = 1
                    } else {
                        storage.overallGameEndingResult = 2
                    }
                    
                    //Adding stuff to Animated
                    var tempAnimatedHold: [
                        type : [color]
                    ] = [:]
                    
                    tempAnimatedHold[.fire] = [.green]
                    
                    for color in tempSet {
                        
                        if let array = storage.localPlayerWinningCardsDisplay[.water] {
                            
                            if array.contains(color) {
                                
                                tempAnimatedHold[.water] = [color]
                                
                                var tempTempSet = tempSet
                                tempTempSet.remove(color)
                        
                                tempAnimatedHold[.ice] = Array(tempTempSet)
                                
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    storage.localPlayerWinningCardsAnimated = tempAnimatedHold
                    
                }
            
            }
        }
        
        
        
        
        //This is for remote player
        
        //Starting off with fire blue
        
        if let array = storage.remotePlayerWinningCardsDisplay[.fire] {
            if array.contains(.blue) {
                //There is a blue fire
                
                var tempSet = Set<color>()
                
                if let array = storage.remotePlayerWinningCardsDisplay[.water] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                if let array = storage.remotePlayerWinningCardsDisplay[.ice] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                tempSet.remove(.blue)
                
                if tempSet.count >= 2 {
                    //WIN
                    if storage.currentPlayer == 2 {
                        storage.overallGameEndingResult = 1
                    } else {
                        storage.overallGameEndingResult = 2
                    }
                    
                    //Adding stuff to Animated
                    var tempAnimatedHold: [
                        type : [color]
                    ] = [:]
                    
                    tempAnimatedHold[.fire] = [.blue]
                    
                    for color in tempSet {
                        
                        if let array = storage.remotePlayerWinningCardsDisplay[.water] {
                            
                            if array.contains(color) {
                                
                                tempAnimatedHold[.water] = [color]
                                
                                var tempTempSet = tempSet
                                tempTempSet.remove(color)
                        
                                tempAnimatedHold[.ice] = Array(tempTempSet)
                                
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    storage.remotePlayerWinningCardsAnimated = tempAnimatedHold
                    
                }
            
            }
        }
        
        
        //Next is fire orange
        
        if let array = storage.remotePlayerWinningCardsDisplay[.fire] {
            if array.contains(.orange) {
                //There is a orange fire
                
                var tempSet = Set<color>()
                
                if let array = storage.remotePlayerWinningCardsDisplay[.water] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                if let array = storage.remotePlayerWinningCardsDisplay[.ice] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                tempSet.remove(.orange)
                
                if tempSet.count >= 2 {
                    //WIN
                    if storage.currentPlayer == 2 {
                        storage.overallGameEndingResult = 1
                    } else {
                        storage.overallGameEndingResult = 2
                    }
                    
                    //Adding stuff to Animated
                    var tempAnimatedHold: [
                        type : [color]
                    ] = [:]
                    
                    tempAnimatedHold[.fire] = [.orange]
                    
                    for color in tempSet {
                        
                        if let array = storage.remotePlayerWinningCardsDisplay[.water] {
                            
                            if array.contains(color) {
                                
                                tempAnimatedHold[.water] = [color]
                                
                                var tempTempSet = tempSet
                                tempTempSet.remove(color)
                        
                                tempAnimatedHold[.ice] = Array(tempTempSet)
                                
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    storage.remotePlayerWinningCardsAnimated = tempAnimatedHold
                    
                }
            
            }
        }
        
        
        //Next is fire green
        
        if let array = storage.remotePlayerWinningCardsDisplay[.fire] {
            if array.contains(.green) {
                //There is a green fire
                
                var tempSet = Set<color>()
                
                if let array = storage.remotePlayerWinningCardsDisplay[.water] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                if let array = storage.remotePlayerWinningCardsDisplay[.ice] {
                    
                    for color in array {
                        tempSet.insert(color)
                    }
                    
                    
                }
                
                tempSet.remove(.green)
                
                if tempSet.count >= 2 {
                    //WIN
                    if storage.currentPlayer == 2 {
                        storage.overallGameEndingResult = 1
                    } else {
                        storage.overallGameEndingResult = 2
                    }
                    
                    //Adding stuff to Animated
                    var tempAnimatedHold: [
                        type : [color]
                    ] = [:]
                    
                    tempAnimatedHold[.fire] = [.green]
                    
                    for color in tempSet {
                        
                        if let array = storage.remotePlayerWinningCardsDisplay[.water] {
                            
                            if array.contains(color) {
                                
                                tempAnimatedHold[.water] = [color]
                                
                                var tempTempSet = tempSet
                                tempTempSet.remove(color)
                        
                                tempAnimatedHold[.ice] = Array(tempTempSet)
                                
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    storage.remotePlayerWinningCardsAnimated = tempAnimatedHold
                    
                }
            
            }
        }
        
        
        
        
    }
    
    
    
//Make sure you send the overallGameEndingResult value based off of orginal player. (DONT USE LOCAL AND REMOTE)
    
    
    /*
     if storage.winningSelectionsPlayer1.count == 3 {
         storage.overallGameEndingResult = 1
     } else if storage.winningSelectionsPlayer2.count == 3 {
         storage.overallGameEndingResult = 2
     }
     */
    
}
