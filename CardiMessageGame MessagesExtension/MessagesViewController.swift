//
//  MessagesViewController.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//


import SwiftUI
import UIKit
import Messages
import Combine


class MessagesViewController: MSMessagesAppViewController {
    
    
    var storage = AppStorage()
    
    
    
    var sendMessageText = ""
    //Sends the message (Don't really know how this works)
    
    
    //Need to add this for each variable from ( // Information bridge from swiftUI to UIkit )
    private var cancellable1: AnyCancellable!
    private var cancellable2: AnyCancellable!
    private var cancellable3: AnyCancellable!
    private var cancellable4: AnyCancellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        //Information bridge from swiftUI to UIkit
        self.cancellable1 = storage.$send.sink { info in
            //Gets information from Swift UI
            //Use name variable within this thing to assign to things
            //https://youtu.be/CNhcAz40Myw
            //https://www.youtube.com/watch?v=Ent5zMwt-h4&t=0s
            
            
            //uses info vairable
            print("\(info) toggle")
            //runs function
            self.createMessage()
        }
        
        self.cancellable4 = storage.$newGame.sink { info in
            //Gets information from Swift UI
            //Use name variable within this thing to assign to things
            //https://youtu.be/CNhcAz40Myw
            //https://www.youtube.com/watch?v=Ent5zMwt-h4&t=0s
            
            
            //uses info vairable
            print("\(info) toggle")
            //runs function
            self.StartNewGame()
        }
        
        self.cancellable2 = storage.$goToCompactView.sink { info in
            //Gets information from Swift UI
            //Use name variable within this thing to assign to things
            //https://youtu.be/CNhcAz40Myw
            //https://www.youtube.com/watch?v=Ent5zMwt-h4&t=0s
            
            
            //uses info vairable
            
            //runs function
            if info == true {
                self.requestPresentationStyle(.compact)
                self.storage.goToCompactView = false
            }
        }
        
        self.cancellable3 = storage.$goToExpnadedView.sink { info in
            //Gets information from Swift UI
            //Use name variable within this thing to assign to things
            //https://youtu.be/CNhcAz40Myw
            //https://www.youtube.com/watch?v=Ent5zMwt-h4&t=0s
            
            
            //uses info vairable
            
            //runs function
            if info == true {
                self.requestPresentationStyle(.expanded)
                self.storage.goToExpnadedView = false
            }
        }
        
        
    }
    
    //Handle information sent in imessage
    override func didSelect(_ message: MSMessage, conversation: MSConversation) {
        print("DEBUGCARTER - didSelect - \(message.debugDescription)")
        //
        // access selected message's custom data
        //
        
        storage.messageDataExists = true
        
        messageReader(message)
        
        
        
        print("NEWBSDOAIFJKLM thing")
        
        let controller = UIHostingController(rootView: FinalWrappedExpanded().environmentObject(storage))
        
        self.addChild(controller)
        self.view.addSubview(controller.view)
        // controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            controller.view.heightAnchor.constraint(equalTo: view.heightAnchor)
            
        ]
        )
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    // MARK: - Conversation Handling
    
    override func didBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        if conversation.selectedMessage != nil {
            storage.messageDataExists = true
            print("Message data exsists")
        } else {
            storage.messageDataExists = false
            print("Message data does not exist")
        }
        
        print("DEBUGCARTER - didBecomeActive - \(conversation.debugDescription)")
        
        //Adds users active in the conversation
        
        
        storage.participantsInConversasion.insert(conversation.localParticipantIdentifier.uuidString)
        
        
        /*
         if let message = conversation.selectedMessage {
         storage.participantsInConversasion.insert(message.senderParticipantIdentifier.uuidString)
         }
         
         */
        storage.localParticipantIdentifier = conversation.localParticipantIdentifier.uuidString
        storage.SenderParticipantIdentifier = conversation.selectedMessage?.senderParticipantIdentifier.uuidString ?? "NoneError"
        var temp: [String] = []
        for participant in conversation.remoteParticipantIdentifiers {
            temp.append(participant.uuidString)
            
        }
        storage.remoteParticipantIdentifiers = temp
        
        if presentationStyle == .expanded && conversation.selectedMessage != nil {
            
            
            let controller = UIHostingController(rootView: FinalWrappedExpanded().environmentObject(storage))
            
            self.addChild(controller)
            self.view.addSubview(controller.view)
            
            // controller.didMove(toParent: self)
            
            NSLayoutConstraint.activate([
                
                controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                
                controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                controller.view.topAnchor.constraint(equalTo: view.topAnchor),
                
                controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
                
                controller.view.heightAnchor.constraint(equalTo: view.heightAnchor)
                
            ]
            )
            
            controller.view.translatesAutoresizingMaskIntoConstraints = false
        } else {
            let controller = UIHostingController(rootView: WrappedCompact().environmentObject(storage))
            
            self.addChild(controller)
            self.view.addSubview(controller.view)
            //controller.didMove(toParent: self)
            
            
            NSLayoutConstraint.activate([
                
                controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                
                controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                controller.view.topAnchor.constraint(equalTo: view.topAnchor),
                
                controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
                
                controller.view.heightAnchor.constraint(equalTo: view.heightAnchor)
                
            ]
            )
            
            controller.view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        
        
        
        
        
        
        
        
        let selectedMessage = conversation.selectedMessage
        if let selectedMessage = selectedMessage {
            
            
            //READS DATA
            
            
            
            messageReader(selectedMessage)
            
            
        }
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dismisses the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
        
    }
    
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
        print("DEBUGCARTER - didReceive - \(message.debugDescription)")
        
        // Check to see if the incoming message is part of a session
        if let incomingSession = message.session {
            // Check to see if the incoming session matches the current message’s session
            if incomingSession == conversation.selectedMessage?.session {
                // Update your user interface here...
                
                messageReader(message)
                
                
                
                
                storage.participantsInConversasion.insert(conversation.localParticipantIdentifier.uuidString)
                
                /*
                 if let message = conversation.selectedMessage {
                 storage.participantsInConversasion.insert(message.senderParticipantIdentifier.uuidString)
                 }
                 
                 */
                
                storage.localParticipantIdentifier = conversation.localParticipantIdentifier.uuidString
                storage.SenderParticipantIdentifier = message.senderParticipantIdentifier.uuidString
                
                var temp: [String] = []
                for participant in conversation.remoteParticipantIdentifiers {
                    temp.append(participant.uuidString)
                    
                }
                storage.remoteParticipantIdentifiers = temp
                
            }
        }
        
        
        
        
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
        
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
        
        // Use this method to prepare for the change in presentation style.
        
        
        
        
        
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        
        print("DEBUGCARTER - didTransition")
        if presentationStyle == .compact && storage.settingsMenuActive == true {
            storage.settingsMenuActive = false
        }
        
        // Called after the extension transitions to a new presentation style.
        
        // Use this method to finalize any behaviors associated with the change in presentation style.
        
        
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        
        if presentationStyle == .expanded && storage.messageDataExists == true {
            
            print("ShowingDebug - showing game - \(storage.messageDataExists.description)")
            
            let controller = UIHostingController(rootView: FinalWrappedExpanded().environmentObject(storage))
            
            self.addChild(controller)
            self.view.addSubview(controller.view)
            // controller.didMove(toParent: self)
            
            NSLayoutConstraint.activate([
                
                controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                
                controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                controller.view.topAnchor.constraint(equalTo: view.topAnchor),
                
                controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
                
                controller.view.heightAnchor.constraint(equalTo: view.heightAnchor)
                
            ]
            )
            
            controller.view.translatesAutoresizingMaskIntoConstraints = false
        } else {
            
            print("ShowingDebug - showing compact - \(storage.messageDataExists.description)")
            let controller = UIHostingController(rootView: WrappedCompact().environmentObject(storage))
            
            self.addChild(controller)
            self.view.addSubview(controller.view)
            // controller.didMove(toParent: self)
            
            NSLayoutConstraint.activate([
                
                controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                
                controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                controller.view.topAnchor.constraint(equalTo: view.topAnchor),
                
                controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
                
                controller.view.heightAnchor.constraint(equalTo: view.heightAnchor)
                
            ]
            )
            
            controller.view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    
    
    func messageReader(_ message: MSMessage) {
        
        
        
        
        //Clears past data
        
        
        
        //READS DATA
        
        //NEED TO CHANGE BELOW #Update#
        
        if let InputNumber = message.md.integer(forKey: "pastRoundselectionPlayer1Number") {
            // do sth with Int
            
            if let InputType = message.md.integer(forKey: "pastRoundselectionPlayer1Type") {
                
                if let InputColor = message.md.integer(forKey: "pastRoundselectionPlayer1Color") {
                    
                    
                    self.storage.pastRoundselectionPlayer1 = cardCreator(number: InputNumber, type: InputType, color: InputColor)
                    
                    
                    
                }
            }
        }
        //NEED TO CHANGE BELOW #Update#
        
        if let InputNumber = message.md.integer(forKey: "pastRoundselectionPlayer2Number") {
            // do sth with Int
            
            if let InputType = message.md.integer(forKey: "pastRoundselectionPlayer2Type") {
                
                if let InputColor = message.md.integer(forKey: "pastRoundselectionPlayer2Color") {
                    
                    
                    self.storage.pastRoundselectionPlayer2 = cardCreator(number: InputNumber, type: InputType, color: InputColor)
                    
                    
                    
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
        
        //NEED TO CHANGE BELOW #Update#
        
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
                    
                    
                    var cardHolder: [Card] = []
                    
                    if listOfReadableNumbers.count > 0 {
                        for count in 0...(listOfReadableNumbers.count - 1) {
                            cardHolder.append(cardCreator(number: listOfReadableNumbers[count], type: listOfReadableTypes[count], color: listOfReadableColors[count]))
                        }
                        
                    }
                    self.storage.winningSelectionsPlayer1 = cardHolder
                }
            }
        }
        
        //NEED TO CHANGE BELOW #Update#
        
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
                    
                    
                    var cardHolder: [Card] = []
                    
                    if listOfReadableNumbers.count > 0 {
                        for count in 0...listOfReadableNumbers.count {
                            cardHolder.append(cardCreator(number: listOfReadableNumbers[count], type: listOfReadableTypes[count], color: listOfReadableColors[count]))
                        }
                    }
                    
                    self.storage.winningSelectionsPlayer2 = cardHolder
                }
            }
        }
        
        //NEED TO CHANGE BELOW #Update#
        
        if let InputNumber = message.md.integer(forKey: "player1SelectionNumber") {
            // do sth with Int
            
            if let InputType = message.md.integer(forKey: "player1SelectionType") {
                
                if let InputColor = message.md.integer(forKey: "player1SelectionColor") {
                    
                    
                    self.storage.player1Selection = cardCreator(number: InputNumber, type: InputType, color: InputColor)
                    
                    
                    
                }
            }
        }
        
        
        //NEED TO CHANGE BELOW #Update#
        
        if let InputNumber = message.md.integer(forKey: "player2SelectionNumber") {
            // do sth with Int
            
            if let InputType = message.md.integer(forKey: "player2SelectionType") {
                
                if let InputColor = message.md.integer(forKey: "player2SelectionColor") {
                    
                    
                    self.storage.player2Selection = cardCreator(number: InputNumber, type: InputType, color: InputColor)
                    
                    
                    
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
        
        
        
        
        checkForWin()
        
    }
    
    
    
    
    
    func checkForRoundWin() {
        
        if let localPlayerSelection = storage.localPlayerSelection {
            
            
            
            if let remotePlayerSelection = storage.remotePlayerSelection {
                
                
                
                //Set Current Round Result to display for user
                if localPlayerSelection.typeNum == 1 && remotePlayerSelection.typeNum == 1 {
                    storage.tempPastRoundResult = 3
                    storage.pastRoundResultSide = storage.currentPlayer
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
                    storage.tempPastRoundResult = 3
                    storage.pastRoundResultSide = storage.currentPlayer
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
                    storage.tempPastRoundResult = 3
                    storage.pastRoundResultSide = storage.currentPlayer
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
        
        //NEED TO CHANGE BELOW #Update#
        
        if let player1Selection = storage.player1Selection {
            message.md.set(value: player1Selection.number, forKey: "player1SelectionNumber")
            message.md.set(value: player1Selection.typeNum, forKey: "player1SelectionType")
            message.md.set(value: player1Selection.colorNum, forKey: "player1SelectionColor")
        }
        
        
        if let player2Selection = storage.player2Selection {
            message.md.set(value: player2Selection.number, forKey: "player2SelectionNumber")
            message.md.set(value: player2Selection.typeNum, forKey: "player2SelectionType")
            message.md.set(value: player2Selection.colorNum, forKey: "player2SelectionColor")
        }
       
       
        message.md.set(value: storage.tempPastRoundResult, forKey: "tempPastRoundResult")
        message.md.set(value: storage.pastRoundResultSide, forKey: "pastRoundResultSide")
        message.md.set(values: storage.winningSelectionsPlayer1NumberConvertedToNum, forKey: "winningSelectionsPlayer1Number")
        message.md.set(values: storage.winningSelectionsPlayer1TypeConvertedToNum, forKey: "winningSelectionsPlayer1Type")
        message.md.set(values: storage.winningSelectionsPlayer1ColorConvertedToNum, forKey: "winningSelectionsPlayer1Color")
        message.md.set(values: storage.winningSelectionsPlayer2NumberConvertedToNum, forKey: "winningSelectionsPlayer2Number")
        message.md.set(values: storage.winningSelectionsPlayer2TypeConvertedToNum, forKey: "winningSelectionsPlayer2Type")
        message.md.set(values: storage.winningSelectionsPlayer2ColorConvertedToNum, forKey: "winningSelectionsPlayer2Color")
        
        if let pastRoundselectionPlayer1 = storage.pastRoundselectionPlayer1 {
            message.md.set(value: pastRoundselectionPlayer1.number, forKey: "pastRoundselectionPlayer1Number")
            message.md.set(value: pastRoundselectionPlayer1.typeNum, forKey: "pastRoundselectionPlayer1Type")
            message.md.set(value: pastRoundselectionPlayer1.colorNum, forKey: "pastRoundselectionPlayer1Color")
        }
        
        if let pastRoundselectionPlayer2 = storage.pastRoundselectionPlayer2 {
            message.md.set(value: pastRoundselectionPlayer2.number, forKey: "pastRoundselectionPlayer2Number")
            message.md.set(value: pastRoundselectionPlayer2.typeNum, forKey: "pastRoundselectionPlayer2Type")
            message.md.set(value: pastRoundselectionPlayer2.colorNum, forKey: "pastRoundselectionPlayer2Color")
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
    
    func StartNewGame() {
        
        
        
        // 1: return the extension to compact mode
        requestPresentationStyle(.compact)

        // 2: do a quick sanity check to make sure we have a conversation to work with
        guard let conversation = activeConversation else { return }

        


        // 4: create a new one
        let session =  MSSession()

        // 5: create a new message from the session and assign it the URL we created from our dates and votes
        let message = MSMessage(session: session)
        
        
        
        //Just sending normal image
                let layout = MSMessageTemplateLayout()
                layout.caption = "New Game"
                layout.image = UIImage(named: "France")
                message.layout = layout
        

        //MAKE SURE YOU SEND DEFAULT DATA
        
        message.md.set(values: [conversation.localParticipantIdentifier.uuidString], forKey: "participantsInConversasion")
        message.md.set(value: conversation.localParticipantIdentifier.uuidString, forKey: "Player1")
        
        //Sets current player turn
        //Player 2 should go first
        message.md.set(value: 2, forKey: "currentPlayerTurn")
        
        // 7: Can replace insert with send inorder to force send message
        conversation.insert(message) { error in
            if let error = error {
                print(error)
            }
        }
        
        
        
    }
    
    

}



