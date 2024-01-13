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
        
        storage.initialCardRandomizer()
        
        message.md.set(values: storage.Player1CardsNumberConvertedToNum, forKey: "Player1CardsNumber")
        message.md.set(values: storage.Player1CardsTypeConvertedToNum, forKey: "Player1CardsType")
        message.md.set(values: storage.Player1CardsColorConvertedToNum, forKey: "Player1CardsColor")
        message.md.set(values: storage.Player1CardsAnimationConvertedToNum, forKey: "Player1CardsAnimation")
        message.md.set(values: storage.Player2CardsNumberConvertedToNum, forKey: "Player2CardsNumber")
        message.md.set(values: storage.Player2CardsTypeConvertedToNum, forKey: "Player2CardsType")
        message.md.set(values: storage.Player2CardsColorConvertedToNum, forKey: "Player2CardsColor")
        message.md.set(values: storage.Player2CardsAnimationConvertedToNum, forKey: "Player2CardsAnimation")
        
        
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



