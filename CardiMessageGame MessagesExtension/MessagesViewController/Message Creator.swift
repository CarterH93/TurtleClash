//
//  Message Creator.swift
//  CardiMessageGame MessagesExtension
//
//  Created by Carter Hawkins on 12/24/23.
//

import SwiftUI
import UIKit
import Messages
import Combine

extension MessagesViewController {
    
    func createMessage() {
        // 1: return the extension to compact mode
        
        //For now I am thinking we dont move to compact mode. This mirrors Gamepigeon logic.
      //  requestPresentationStyle(.compact)

        // 2: do a quick sanity check to make sure we have a conversation to work with
        guard let conversation = activeConversation else { return }

        


        // 4: use the existing session or create a new one
        let session = conversation.selectedMessage?.session ?? MSSession()

        // 5: create a new message from the session and assign it the URL we created from our dates and votes
        let message = MSMessage(session: session)
        
        
        
        //Just sending normal image
                let layout = MSMessageTemplateLayout()
                layout.caption = storage.name
                layout.image = UIImage(named: "France")
                message.layout = layout
        
/*
        // 6: create a blank, default message layout
        let layout = MSMessageTemplateLayout()
        layout.caption = storage.name
        //layout.image = UIImage(named: "France")
        layout.mediaFileURL = Bundle.main.url(forResource: "Animated Image", withExtension: ".png")
        
        let messageLayout = MSMessageLiveLayout(alternateLayout: layout)
        
       
        
        
        
        message.layout = messageLayout
 */
        
        
        checkForRoundWin()
        checkForWin()
        
        //Sets current player turn
        if storage.currentPlayerTurn == 2 {
            message.md.set(value: 1, forKey: "currentPlayerTurn")
        } else {
            message.md.set(value: 2, forKey: "currentPlayerTurn")
        }
        
         
        
        if let player1Selection = storage.player1Selection {
            message.md.set(value: player1Selection.number, forKey: "player1SelectionNumber")
            message.md.set(value: player1Selection.typeNum, forKey: "player1SelectionType")
            message.md.set(value: player1Selection.colorNum, forKey: "player1SelectionColor")
            message.md.set(value: player1Selection.animation, forKey: "player1SelectionAnimation")
        }
        
        
        if let player2Selection = storage.player2Selection {
            message.md.set(value: player2Selection.number, forKey: "player2SelectionNumber")
            message.md.set(value: player2Selection.typeNum, forKey: "player2SelectionType")
            message.md.set(value: player2Selection.colorNum, forKey: "player2SelectionColor")
            message.md.set(value: player2Selection.animation, forKey: "player2SelectionAnimation")
        }
       
       
        message.md.set(value: storage.tempPastRoundResult, forKey: "tempPastRoundResult")
        message.md.set(value: storage.pastRoundResultSide, forKey: "pastRoundResultSide")
        message.md.set(values: storage.winningSelectionsPlayer1NumberConvertedToNum, forKey: "winningSelectionsPlayer1Number")
        message.md.set(values: storage.winningSelectionsPlayer1TypeConvertedToNum, forKey: "winningSelectionsPlayer1Type")
        message.md.set(values: storage.winningSelectionsPlayer1ColorConvertedToNum, forKey: "winningSelectionsPlayer1Color")
        message.md.set(values: storage.winningSelectionsPlayer1AnimationConvertedToNum, forKey: "winningSelectionsPlayer1Animation")
        message.md.set(values: storage.winningSelectionsPlayer2NumberConvertedToNum, forKey: "winningSelectionsPlayer2Number")
        message.md.set(values: storage.winningSelectionsPlayer2TypeConvertedToNum, forKey: "winningSelectionsPlayer2Type")
        message.md.set(values: storage.winningSelectionsPlayer2ColorConvertedToNum, forKey: "winningSelectionsPlayer2Color")
        message.md.set(values: storage.winningSelectionsPlayer2AnimationConvertedToNum, forKey: "winningSelectionsPlayer2Animation")
        
        message.md.set(values: storage.Player1CardsNumberConvertedToNum, forKey: "Player1CardsNumber")
        message.md.set(values: storage.Player1CardsTypeConvertedToNum, forKey: "Player1CardsType")
        message.md.set(values: storage.Player1CardsColorConvertedToNum, forKey: "Player1CardsColor")
        message.md.set(values: storage.Player1CardsAnimationConvertedToNum, forKey: "Player1CardsAnimation")
        message.md.set(values: storage.Player2CardsNumberConvertedToNum, forKey: "Player2CardsNumber")
        message.md.set(values: storage.Player2CardsTypeConvertedToNum, forKey: "Player2CardsType")
        message.md.set(values: storage.Player2CardsColorConvertedToNum, forKey: "Player2CardsColor")
        message.md.set(values: storage.Player2CardsAnimationConvertedToNum, forKey: "Player2CardsAnimation")
        
        
        if let pastRoundselectionPlayer1 = storage.pastRoundselectionPlayer1 {
            message.md.set(value: pastRoundselectionPlayer1.number, forKey: "pastRoundselectionPlayer1Number")
            message.md.set(value: pastRoundselectionPlayer1.typeNum, forKey: "pastRoundselectionPlayer1Type")
            message.md.set(value: pastRoundselectionPlayer1.colorNum, forKey: "pastRoundselectionPlayer1Color")
            message.md.set(value: pastRoundselectionPlayer1.animation, forKey: "pastRoundselectionPlayer1Animation")
        }
        
        if let pastRoundselectionPlayer2 = storage.pastRoundselectionPlayer2 {
            message.md.set(value: pastRoundselectionPlayer2.number, forKey: "pastRoundselectionPlayer2Number")
            message.md.set(value: pastRoundselectionPlayer2.typeNum, forKey: "pastRoundselectionPlayer2Type")
            message.md.set(value: pastRoundselectionPlayer2.colorNum, forKey: "pastRoundselectionPlayer2Color")
            message.md.set(value: pastRoundselectionPlayer2.animation, forKey: "pastRoundselectionPlayer2Animation")
        }
        
      
        
        if storage.player1.isEmpty == true {
            storage.player1 = conversation.localParticipantIdentifier.uuidString
        } else if storage.player2.isEmpty == true {
            storage.player2 = conversation.localParticipantIdentifier.uuidString
        }
        
        
        if storage.player1.isEmpty == false {
            message.md.set(value: storage.player1, forKey: "Player1")
        }
       
        if storage.player2.isEmpty == false {
            message.md.set(value: storage.player2, forKey: "Player2")
        }
        
        message.md.set(values: Array(storage.participantsInConversasion), forKey: "participantsInConversasion")
        
        
        // 7: Can replace insert with send inorder to force send message
        conversation.send(message) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    
}
