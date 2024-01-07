//
//  Message Reader.swift
//  CardiMessageGame MessagesExtension
//
//  Created by Carter Hawkins on 12/24/23.
//

import SwiftUI
import UIKit
import Messages
import Combine


extension MessagesViewController {
    
    
    func messageReader(_ message: MSMessage) {
        
      

        
        
        
        //READS DATA
        
         
        
        if let InputNumber = message.md.integer(forKey: "pastRoundselectionPlayer1Number") {
            // do sth with Int
            
            if let InputType = message.md.integer(forKey: "pastRoundselectionPlayer1Type") {
                
                if let InputColor = message.md.integer(forKey: "pastRoundselectionPlayer1Color") {
                    
                    
                    if let InputAnimation = message.md.integer(forKey: "pastRoundselectionPlayer1Animation") {
                        
                        self.storage.pastRoundselectionPlayer1 = cardCreator(number: InputNumber, type: InputType, color: InputColor, animation: InputAnimation)
                        
                        
                        
                    }
                }
            }
        }
         
        
        if let InputNumber = message.md.integer(forKey: "pastRoundselectionPlayer2Number") {
            // do sth with Int
            
            if let InputType = message.md.integer(forKey: "pastRoundselectionPlayer2Type") {
                
                if let InputColor = message.md.integer(forKey: "pastRoundselectionPlayer2Color") {
                    
                    if let InputAnimation = message.md.integer(forKey: "pastRoundselectionPlayer2Animation") {
                        
                        
                        self.storage.pastRoundselectionPlayer2 = cardCreator(number: InputNumber, type: InputType, color: InputColor, animation: InputAnimation)
                        
                        
                    }
                }
            }
        }
        
        
        
        //Reads Previous Round result to show player
        if let InputInt = message.md.integer(forKey: "tempPastRoundResult") {
            // do sth with Int
            
            
            
            
            
            self.storage.tempPastRoundResult = InputInt
            // print("IMPORTANT:    \(Inputtext)")
            
            
        }
        if let InputInt = message.md.integer(forKey: "pastRoundResultSide") {
            // do sth with Int
            
            
            
            
            
            self.storage.pastRoundResultSide = InputInt
            // print("IMPORTANT:    \(Inputtext)")
            
            
        }
        
        
        
        //Sets current player turn based on recieved value
        if let InputInt = message.md.integer(forKey: "currentPlayerTurn") {
            // do sth with Int
            
            
            
            
            
            self.storage.currentPlayerTurn = InputInt
            // print("IMPORTANT:    \(Inputtext)")
            
            
        }
        
         
        
        if let Numbers = message.md.values(forKey: "winningSelectionsPlayer1Number") {
            var listOfReadableNumbers: [Int] = []
            for object in Numbers {
                let i = object as! Int
                listOfReadableNumbers.append(i)
            }
            
            if let Types = message.md.values(forKey: "winningSelectionsPlayer1Type") {
                var listOfReadableTypes: [Int] = []
                for object in Types {
                    let i = object as! Int
                    listOfReadableTypes.append(i)
                }
                
                
                if let Colors = message.md.values(forKey: "winningSelectionsPlayer1Color") {
                    var listOfReadableColors: [Int] = []
                    for object in Colors {
                        let i = object as! Int
                        listOfReadableColors.append(i)
                    }
                    
                    if let Animations = message.md.values(forKey: "winningSelectionsPlayer1Animation") {
                        var listOfReadableAnimations: [Int] = []
                        for object in Animations {
                            let i = object as! Int
                            listOfReadableAnimations.append(i)
                        }
                        
                        
                        var cardHolder: [Card] = []
                        
                        if listOfReadableNumbers.count > 0 {
                            for count in 0...(listOfReadableNumbers.count - 1) {
                                cardHolder.append(cardCreator(number: listOfReadableNumbers[count], type: listOfReadableTypes[count], color: listOfReadableColors[count], animation: listOfReadableAnimations[count]))
                            }
                            
                        }
                        self.storage.winningSelectionsPlayer1 = cardHolder
                    }
                }
            }
        }
        
         
        
        if let Numbers = message.md.values(forKey: "winningSelectionsPlayer2Number") {
            var listOfReadableNumbers: [Int] = []
            for object in Numbers {
                let i = object as! Int
                listOfReadableNumbers.append(i)
            }
            
            if let Types = message.md.values(forKey: "winningSelectionsPlayer2Type") {
                var listOfReadableTypes: [Int] = []
                for object in Types {
                    let i = object as! Int
                    listOfReadableTypes.append(i)
                }
                
                
                if let Colors = message.md.values(forKey: "winningSelectionsPlayer2Color") {
                    var listOfReadableColors: [Int] = []
                    for object in Colors {
                        let i = object as! Int
                        listOfReadableColors.append(i)
                    }
                    
                    
                    if let Animations = message.md.values(forKey: "winningSelectionsPlayer2Animation") {
                        var listOfReadableAnimations: [Int] = []
                        for object in Animations {
                            let i = object as! Int
                            listOfReadableAnimations.append(i)
                        }
                        
                        
                        var cardHolder: [Card] = []
                        
                        if listOfReadableNumbers.count > 0 {
                            for count in 0...(listOfReadableNumbers.count - 1) {
                                cardHolder.append(cardCreator(number: listOfReadableNumbers[count], type: listOfReadableTypes[count], color: listOfReadableColors[count], animation: listOfReadableAnimations[count]))
                            }
                        }
                        
                        self.storage.winningSelectionsPlayer2 = cardHolder
                    }
                }
            }
        }
        
         
        
        //DIVIDER
        
        
        if let Numbers = message.md.values(forKey: "Player1CardsNumber") {
            var listOfReadableNumbers: [Int] = []
            for object in Numbers {
                let i = object as! Int
                listOfReadableNumbers.append(i)
            }
            
            if let Types = message.md.values(forKey: "Player1CardsType") {
                var listOfReadableTypes: [Int] = []
                for object in Types {
                    let i = object as! Int
                    listOfReadableTypes.append(i)
                }
                
                
                if let Colors = message.md.values(forKey: "Player1CardsColor") {
                    var listOfReadableColors: [Int] = []
                    for object in Colors {
                        let i = object as! Int
                        listOfReadableColors.append(i)
                    }
                    
                    if let Animations = message.md.values(forKey: "Player1CardsAnimation") {
                        var listOfReadableAnimations: [Int] = []
                        for object in Animations {
                            let i = object as! Int
                            listOfReadableAnimations.append(i)
                        }
                        
                        
                        var cardHolder: [Card] = []
                        
                        if listOfReadableNumbers.count > 0 {
                            for count in 0...(listOfReadableNumbers.count - 1) {
                                cardHolder.append(cardCreator(number: listOfReadableNumbers[count], type: listOfReadableTypes[count], color: listOfReadableColors[count], animation: listOfReadableAnimations[count]))
                            }
                            
                        }
                        self.storage.Player1Cards = cardHolder
                    }
                }
            }
        }
        
         
        
        if let Numbers = message.md.values(forKey: "Player2CardsNumber") {
            var listOfReadableNumbers: [Int] = []
            for object in Numbers {
                let i = object as! Int
                listOfReadableNumbers.append(i)
            }
            
            if let Types = message.md.values(forKey: "Player2CardsType") {
                var listOfReadableTypes: [Int] = []
                for object in Types {
                    let i = object as! Int
                    listOfReadableTypes.append(i)
                }
                
                
                if let Colors = message.md.values(forKey: "Player2CardsColor") {
                    var listOfReadableColors: [Int] = []
                    for object in Colors {
                        let i = object as! Int
                        listOfReadableColors.append(i)
                    }
                    
                    
                    if let Animations = message.md.values(forKey: "Player2CardsAnimation") {
                        var listOfReadableAnimations: [Int] = []
                        for object in Animations {
                            let i = object as! Int
                            listOfReadableAnimations.append(i)
                        }
                        
                        
                        var cardHolder: [Card] = []
                        
                        if listOfReadableNumbers.count > 0 {
                            for count in 0...(listOfReadableNumbers.count - 1) {
                                cardHolder.append(cardCreator(number: listOfReadableNumbers[count], type: listOfReadableTypes[count], color: listOfReadableColors[count], animation: listOfReadableAnimations[count]))
                            }
                        }
                        
                        self.storage.Player2Cards = cardHolder
                    }
                }
            }
        }
        
        //DIVIDER
        
        
        
        
        if let InputNumber = message.md.integer(forKey: "player1SelectionNumber") {
            // do sth with Int
            
            if let InputType = message.md.integer(forKey: "player1SelectionType") {
                
                if let InputColor = message.md.integer(forKey: "player1SelectionColor") {
                    
                    
                    if let InputAnimation = message.md.integer(forKey: "player1SelectionAnimation") {
                        
                        self.storage.player1Selection = cardCreator(number: InputNumber, type: InputType, color: InputColor, animation: InputAnimation)
                        
                        
                    }
                }
            }
        }
        
        
         
        
        if let InputNumber = message.md.integer(forKey: "player2SelectionNumber") {
            // do sth with Int
            
            if let InputType = message.md.integer(forKey: "player2SelectionType") {
                
                if let InputColor = message.md.integer(forKey: "player2SelectionColor") {
                    
                    
                    if let InputAnimation = message.md.integer(forKey: "player2SelectionAnimation") {
                        
                        self.storage.player2Selection = cardCreator(number: InputNumber, type: InputType, color: InputColor, animation: InputAnimation)
                        
                        
                    }
                }
            }
        }
        if let Inputtext = message.md.values(forKey: "participantsInConversasion") {
            // do sth with Participants in conversation
            
            for item in Inputtext {
                self.storage.participantsInConversasion.insert(String(describing: item))
            }
            
        }
        
        if let Inputtext = message.md.string(forKey: "Player1") {
            // do sth with Player 1
            
            
            
            
            
            self.storage.player1 = Inputtext
            
            
            
        }
        
        
        
        
        if let Inputtext = message.md.string(forKey: "Player2") {
            // do sth with Player 2
            
            
            
            
            
            self.storage.player2 = Inputtext
            
            
            
        }
        
        
        
        
        
        
    }
    
    
}
