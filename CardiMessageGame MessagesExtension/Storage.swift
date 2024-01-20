//
//  Storage.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//


import SwiftUI
import Messages

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

let saveMove = getDocumentsDirectory().appendingPathComponent("SavedMove")

class AppStorage: ObservableObject {
    
    let battleAnimationLength = 5
    
    
    @Published var tempMessageDataHold: MSMessage? = nil
    
    @Published var messageHashValue: String = ""
    
    @Published var savedMove: [String:Card] {
        
        //did set for saving data to the disk
        
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(savedMove) {
                
                let str = encoded
                let url = saveMove
                
                do {
                    try str.write(to: url, options: .atomicWrite)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    init() {
            if let savedItems = try? Data(contentsOf: saveMove) {
                if let decodedItems = try? JSONDecoder().decode([String:Card].self, from: savedItems) {
                    savedMove = decodedItems
                    return
                }
            }
        savedMove = [:]
        }
    
    
    
    let highestCardNumber = 12
    let highestAnimationNumber = 5
    
    @Published var Player1Cards: [Card] = []

    @Published var Player2Cards: [Card] = []
    
    var localPlayerCards: [Card] {
        if currentPlayer == 1 {
            return Player1Cards
        } else {
            return Player2Cards
        }
    }
    
    
    func initialCardRandomizer() {
        
        var tempLocalCardHold = Set<Card>()
        var tempRemoteCardHold = Set<Card>()
        
        while tempLocalCardHold.count < 5 {
            let number = Int.random(in: 1...highestCardNumber)
            let type = Int.random(in: 1...3)
            let color = Int.random(in: 1...3)
            let animation = Int.random(in: 1...highestAnimationNumber)
            
            let tempCardHold = cardCreator(number: number, type: type, color: color, animation: animation)
            
            var unique = true
            
            for card in tempLocalCardHold {
                if card.number == tempCardHold.number && card.color == tempCardHold.color {
                    unique = false
                }
            }
            
            for card in tempRemoteCardHold {
                if card.number == tempCardHold.number && card.color == tempCardHold.color {
                    unique = false
                }
            }
            
            
            if unique {
                tempLocalCardHold.insert(tempCardHold)
                
            } else {
                //Do nothing
            }
        }
        
      
        
        while tempRemoteCardHold.count < 5 {
            let number = Int.random(in: 1...highestCardNumber)
            let type = Int.random(in: 1...3)
            let color = Int.random(in: 1...3)
            let animation = Int.random(in: 1...highestAnimationNumber)
            
            let tempCardHold = cardCreator(number: number, type: type, color: color, animation: animation)
            
            var unique = true
            
            for card in tempLocalCardHold {
                if card.number == tempCardHold.number && card.color == tempCardHold.color {
                    unique = false
                }
            }
            
            for card in tempRemoteCardHold {
                if card.number == tempCardHold.number && card.color == tempCardHold.color {
                    unique = false
                }
            }
            
            
            if unique {
                tempRemoteCardHold.insert(tempCardHold)
                
            } else {
                //Do nothing
            }
            
        }
        
        Player1Cards = Array(tempLocalCardHold)
        Player2Cards = Array(tempRemoteCardHold)
    }
    
    func addNewCardToLocalPlayerCards() {
        
        let number = Int.random(in: 1...highestCardNumber)
        let type = Int.random(in: 1...3)
        let color = Int.random(in: 1...3)
        let animation = Int.random(in: 1...highestAnimationNumber)
        
        let tempCardHold = cardCreator(number: number, type: type, color: color, animation: animation)
        
        var unique = true
        
        for card in Player1Cards {
            if card.number == tempCardHold.number && card.color == tempCardHold.color {
                unique = false
            }
        }
        
        for card in Player2Cards {
            if card.number == tempCardHold.number && card.color == tempCardHold.color {
                unique = false
            }
        }
        
        if player1Selection?.number == tempCardHold.number && player1Selection?.color == tempCardHold.color {
            unique = false
        }
        
        if player2Selection?.number == tempCardHold.number && player2Selection?.color == tempCardHold.color {
            unique = false
        }
        
        if pastRoundselectionPlayer1?.number == tempCardHold.number && pastRoundselectionPlayer1?.color == tempCardHold.color {
            unique = false
        }
        
        if pastRoundselectionPlayer2?.number == tempCardHold.number && pastRoundselectionPlayer2?.color == tempCardHold.color {
            unique = false
        }
        
        
        if unique == false {
            //Try all over again
            addNewCardToLocalPlayerCards()
        } else {
            if currentPlayer == 1 {
                Player1Cards.append(tempCardHold)
            } else {
                Player2Cards.append(tempCardHold)
            }
            
            
        }
        
    }
    
    
    @Published var goToCompactView = false
    @Published var goToExpnadedView = false
    
    
    var gameover: Bool {
        if overallGameEndingResult != 0 {
            return true
        } else {
            return false
        }
    }
    
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
    
    //[Card(number: 1, type: .fire, color: .orange, animation: 1),Card(number: 1, type: .fire, color: .blue, animation: 1), Card(number: 1, type: .fire, color: .green, animation: 1), Card(number: 1, type: .water, color: .orange, animation: 1), Card(number: 1, type: .water, color: .blue, animation: 1), Card(number: 1, type: .water, color: .green, animation: 1), Card(number: 1, type: .ice, color: .orange, animation: 1), Card(number: 1, type: .ice, color: .blue, animation: 1), Card(number: 1, type: .ice, color: .green, animation: 1)]
   
    
    @Published var winningSelectionsPlayer1: [Card] = []
    @Published var winningSelectionsPlayer2: [Card] = []
    
    
    
    
    
    
    var localPlayerWinningSelections: [Card] {
        if currentPlayer == 1 {
            return winningSelectionsPlayer1
        } else {
            return winningSelectionsPlayer2
        }
    }
    
    var remotePlayerWinningSelections: [Card] {
        if currentPlayer == 2 {
            return winningSelectionsPlayer1
        } else {
            return winningSelectionsPlayer2
        }
    }
    
    
    
    var localPlayerWinningCardsDisplay: [
        type : [color]
    ] {
        var tempHold: [type : [color]] = [:]
        
        let cards = localPlayerWinningSelections
        
        var fire = [color]()
        var water = [color]()
        var ice = [color]()
        
        for card in cards {
            switch card.type {
            case .fire:
                if fire.contains(card.color) == false {
                    fire.append(card.color)
                }
            case .water:
                if water.contains(card.color) == false {
                    water.append(card.color)
                }
            case .ice:
                if ice.contains(card.color) == false {
                    ice.append(card.color)
                }
            }
        }
        
        tempHold[.fire] = fire
        tempHold[.water] = water
        tempHold[.ice] = ice
        
        return tempHold
    }
    
    var remotePlayerWinningCardsDisplay: [
        type : [color]
    ] {
        var tempHold: [type : [color]] = [:]
        
        let cards = remotePlayerWinningSelections
        
        var fire = [color]()
        var water = [color]()
        var ice = [color]()
        
        for card in cards {
            switch card.type {
            case .fire:
                if fire.contains(card.color) == false {
                    fire.append(card.color)
                }
            case .water:
                if water.contains(card.color) == false {
                    water.append(card.color)
                }
            case .ice:
                if ice.contains(card.color) == false {
                    ice.append(card.color)
                }
            }
        }
        
        tempHold[.fire] = fire
        tempHold[.water] = water
        tempHold[.ice] = ice
        
        return tempHold
    }
    
    
    
    
    @Published var localPlayerWinningCardsAnimated: [
        type : [color]
    ] = [
        .fire:[],
        .ice:[],
        .water:[]
    ]
    
    @Published var remotePlayerWinningCardsAnimated: [
        type : [color]
    ] = [
        .fire:[],
        .ice:[],
        .water:[]
    ]
    
    
    
    
    
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
    
    var winningSelectionsPlayer1AnimationConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in winningSelectionsPlayer1 {
            hold.append(i.animation)
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
    
    var winningSelectionsPlayer2AnimationConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in winningSelectionsPlayer2 {
            hold.append(i.animation)
        }
        
        return hold
    }
    

    
    var Player1CardsTypeConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in Player1Cards {
            hold.append(i.typeNum)
        }
        
        return hold
    }
    
    var Player1CardsColorConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in Player1Cards {
            hold.append(i.colorNum)
        }
        
        return hold
    }
    
    var Player1CardsNumberConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in Player1Cards {
            hold.append(i.number)
        }
        
        return hold
    }
    
    var Player1CardsAnimationConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in Player1Cards {
            hold.append(i.animation)
        }
        
        return hold
    }
    
    var Player2CardsTypeConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in Player2Cards {
            hold.append(i.typeNum)
        }
        
        return hold
    }
    
    var Player2CardsColorConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in Player2Cards {
            hold.append(i.colorNum)
        }
        
        return hold
    }
    
    var Player2CardsNumberConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in Player2Cards {
            hold.append(i.number)
        }
        
        return hold
    }
    
    var Player2CardsAnimationConvertedToNum: [Int] {
        var hold: [Int] = []
        
        for i in Player2Cards {
            hold.append(i.animation)
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
    //number indicates which player won
    
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

func cardCreator(number: Int, type: Int, color: Int, animation: Int) -> Card {
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
    
    return Card(number: number, type: newType, color: newColor, animation: animation)
    
}



