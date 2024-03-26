//
//  Gameplay.swift
//  iMessage Playground
//
//  Created by Carter Hawkins on 12/25/23.
//

import SwiftUI
import AVFoundation
struct Gameplay: View {
    
    @State var tempWinningAnimatedCards: [
        type : [color]
    ] = [
        .fire:[],
        .ice:[],
        .water:[]
    ]
    
    let timeWaitAfterWin: Double = 4
    
    @State private var xPositionOpponentPlayerCard:CGFloat = 0
    @State private var yPositionOpponentPlayerCard:CGFloat = 0
    @State private var xPositionLocalPlayerCard:CGFloat = 0
    @State private var yPositionLocalPlayerCard:CGFloat = 0
    @State private var offsetValueX = 0.0
    @State private var offsetValueY = 0.0
    
    @State private var music: AVAudioPlayer?
    
    let opponentCardOffsetx = -0.28
    let localCardOffsetx = 0.58
    let localCardOffsety = -0.22
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var timeActive = 0.0
    @State private var notShowedSaveMove = true
    
    @EnvironmentObject var storage: AppStorage
    
    
    /// The degree of rotation for the back of the card
    @State var backDegree = 0.0
    /// The degree of rotation for the front of the card
    @State var frontDegree = -90.0
/// A boolean that keeps track of whether the card is flipped or not
@State var isFlipped = false

    /// The duration and delay of the flip animation
    let durationAndDelay : CGFloat = 0.2

/// A function that flips and moves the card by updating the degree of rotation for the front and back of the card
func flipCard() {
    isFlipped = !isFlipped
    if isFlipped {
        withAnimation(.linear(duration: durationAndDelay)) {
            backDegree = 90
        }
        withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
            frontDegree = 0
        }
    } else {
        withAnimation(.linear(duration: durationAndDelay)) {
            frontDegree = -90
        }
        withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
            backDegree = 0
        }
    }
    
    
}
    @State var secondTime = false
    
    let cardWidth: CGFloat = 75
    
    let cardHeight: CGFloat = 115
    
    let animationAmount: CGFloat = -20
    
    @State var disable = false
    
    @State var isDragging = false
    @State var position = CGSize.zero
    @State var opponentCardSize: CGFloat = 1
    
    
    
    
    @State private var selectedCard: Card? = nil
    
    func deselectCards() {
        var hold: [Card] = []
        for card in storage.localPlayerCards {
            var temp = card
            temp.selected = false
            hold.append(temp)
        }
        if storage.currentPlayer == 1 {
            storage.Player1Cards = hold
        } else {
            storage.Player2Cards = hold
        }
    }
        
    
    
    
    
    
   
    
    
    func colorReader(dict: [type : [color]], type: type, at: Int) -> color? {
        let array = dict[type]
        
        
        if let int = array?.count {
            if (int - 1) >= at {
                return array![at]
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Animations()
                    
                
                
                ZStack {
                    VStack(spacing: 0) {
                        HStack {
                            VStack {
                                Spacer()
                                HStack {
                                    WinningStack(icon: .fire, color1: colorReader(dict: storage.remotePlayerWinningCardsDisplay, type: .fire, at: 0), color2: colorReader(dict: storage.remotePlayerWinningCardsDisplay, type: .fire, at: 1), color3: colorReader(dict: storage.remotePlayerWinningCardsDisplay, type: .fire, at: 2), local: false)
                                         
                                    WinningStack(icon: .water, color1: colorReader(dict: storage.remotePlayerWinningCardsDisplay, type: .water, at: 0), color2: colorReader(dict: storage.remotePlayerWinningCardsDisplay, type: .water, at: 1), color3: colorReader(dict: storage.remotePlayerWinningCardsDisplay, type: .water, at: 2), local: false)
                                         
                                    WinningStack(icon: .ice, color1: colorReader(dict: storage.remotePlayerWinningCardsDisplay, type: .ice, at: 0), color2: colorReader(dict: storage.remotePlayerWinningCardsDisplay, type: .ice, at: 1), color3: colorReader(dict: storage.remotePlayerWinningCardsDisplay, type: .ice, at: 2), local: false)
                                         
                                }
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.orange)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.white, lineWidth: 3)
                                        )
                                    
                                    Text("Opponent")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                                .frame(height: 35)
                                .padding(.top, 20)
                            }
                            .frame(width: 100, height: 100)
                            .padding([.leading, .trailing])
                            
                            Spacer()
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            //Bring up help menu
                                            storage.helpMenuVisable = true
                                            //testing purposes
                                           // storage.winningSelectionsPlayer1 = [Card(number: 1, type: .fire, color: .orange, animation: 1),Card(number: 1, type: .fire, color: .blue, animation: 1), Card(number: 1, type: .water, color: .orange, animation: 1), Card(number: 1, type: .water, color: .green, animation: 1),  Card(number: 1, type: .ice, color: .orange, animation: 1), Card(number: 1, type: .ice, color: .blue, animation: 1)]
                                        }
                                    }, label: {
                                        Help()
                                            .frame(width: 40, height: 40)
                                            .padding(.top)
                                    })
                                    
                                        
                                }
                                .padding([.leading, .trailing])
                                
                                HStack(spacing: 0) {
                                    ZStack {
                                        BackCardView()
                                             .frame(width: cardWidth / 2, height: cardHeight / 2)
                                             .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0, y: 1, z: 0))
                                        if let card = storage.pastRemotePlayerSelection {
                                            CardView(card: card)
                                                .frame(width: cardWidth / 2, height: cardHeight / 2)
                                                .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
                                        }
                                    }
                                    .overlay(
                                        GeometryReader { geo  in
                                            Color.clear
                                                .onReceive(timer) { _ in
                                                    xPositionOpponentPlayerCard = geo.frame(in: .global).midX
                                                    yPositionOpponentPlayerCard = geo.frame(in: .global).midY
                                                }
                                        }
                                    )
                                    
                                    .scaleEffect(opponentCardSize, anchor: .center)
                                    .offset(x: offsetValueX, y: offsetValueY)
                                    
                                    
                                    
                                    BackCardView()
                                         .frame(width: cardWidth / 2, height: cardHeight / 2)
                                    BackCardView()
                                         .frame(width: cardWidth / 2, height: cardHeight / 2)
                                    BackCardView()
                                         .frame(width: cardWidth / 2, height: cardHeight / 2)
                                    BackCardView()
                                         .frame(width: cardWidth / 2, height: cardHeight / 2)
                                }
                                .frame(width: 100)
                                .padding()
                                
                            }
                        }
                        .padding([.leading, .trailing])
                        Spacer()
                        
                        HStack {
                            if let selectedCardWrapped = selectedCard {
                                CardView(card: selectedCardWrapped)
                                    .frame(width: cardWidth * 1.3, height: cardHeight * 1.3)
                                    .padding()
                                    .overlay(
                                        GeometryReader{ geo in
                                           Color.clear
                                                .onReceive(timer) { _ in
                                                    xPositionLocalPlayerCard = geo.frame(in: .global).midX
                                                    yPositionLocalPlayerCard = geo.frame(in: .global).midY
                                                        
                                                }
                                        }
                                    )
                                    .offset(x: position.width, y: position.height)
                                    .gesture(
                                        DragGesture()
                                            .onChanged({ value in
                                                withAnimation() {
                                                    position = value.translation
                                                    isDragging = true
                                                }
                                            })
                                            .onEnded({ value in
                                                storage.selectChoice(selectedCardWrapped)
                                                if !secondTime {
                                                    checkForRoundWin()
                                                    
                                                }
                                                
                                                
                                                withAnimation() {
                                                    position = .init(width: geo.size.width * localCardOffsetx, height: geo.size.height * localCardOffsety)
                                                    isDragging = false
                                                    disable = true
                                                }
                                                
                                                if storage.pastRemotePlayerSelection != nil && !secondTime {
                                                    notShowedSaveMove = false
                                                    storage.savedMove[storage.messageHashValue] = selectedCardWrapped
                                                    storage.scheduleWorkItem(withDelay: 1) {
                                                        withAnimation() {
                                                            
                                                           
                                                                offsetValueY = yPositionLocalPlayerCard - yPositionOpponentPlayerCard
                                                            offsetValueX = geo.size.width * opponentCardOffsetx
                                                            
                                                            opponentCardSize = 2.58
                                                        }
                                                        
                                                        storage.scheduleWorkItem(withDelay: 2) {
                                                            withAnimation() {
                                                                flipCard()
                                                                
                                                                if storage.currentPlayer == 1 {
                                                                    storage.Player1Cards.removeAll { value in
                                                                        return value == selectedCard
                                                                    }
                                                                    storage.addNewCardToLocalPlayerCards()
                                                                } else {
                                                                    storage.Player2Cards.removeAll { value in
                                                                        return value == selectedCard
                                                                    }
                                                                    storage.addNewCardToLocalPlayerCards()
                                                                }
                                                                
                                                                
                                                                
                                                                storage.scheduleWorkItem(withDelay: 2) {
                                                                    withAnimation() {
                                                                        offsetValueX = 0
                                                                        offsetValueY = 0
                                                                        opponentCardSize = 1
                                                                        position = CGSize.zero
                                                                       flipCard()
                                                                        selectedCard = nil
                                                                        withAnimation {
                                                                            storage.animationActive = true
                                                                        }
                                                                        storage.scheduleWorkItem(withDelay: storage.battleAnimationLength) {
                                                                            withAnimation {
                                                                                storage.animationActive = false
                                                                            }
                                                                            secondTime = true
                                                                            disable = false
                                                                            
                                                                            withAnimation {
                                                                                checkForWin(2)
                                                                            }
                                                                            if storage.gameover {
                                                                                storage.scheduleWorkItem(withDelay: timeWaitAfterWin) {
                                                                                    
                                                                                    
                                                                                    storage.send.toggle()
                                                                                    
                                                                                    
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                    
                                                        
                                                                    
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    secondTime = false
                                                    storage.selectChoice(selectedCardWrapped)
                                                    if storage.currentPlayer == 1 {
                                                        storage.Player1Cards.removeAll { value in
                                                            return value == selectedCard
                                                        }
                                                        storage.addNewCardToLocalPlayerCards()
                                                    } else {
                                                        storage.Player2Cards.removeAll { value in
                                                            return value == selectedCard
                                                        }
                                                        storage.addNewCardToLocalPlayerCards()
                                                    }
                                                    
                                                    storage.scheduleWorkItem(withDelay: 2) {
                                                        
                                                        
                                                            storage.send.toggle()
                                                        
                                                        
                                                    }
                                                    
                                                }
                                                   
                                                    
                                                
                                            })
                                )
                                    .ignoresSafeArea(.all)
                            } else {
                                
                                    EmptyCard()
                                        .frame(width: cardWidth * 1.3, height: cardHeight * 1.3)
                                        .padding()
                                        .opacity(storage.animationActive ? 0 : 1)
                                
                            }
                            
                            Spacer()
                            
                            VStack(spacing: 0) {
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.green)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.white, lineWidth: 3)
                                        )
                                    
                                    Text("You")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                                .frame(height: 35)
                                .padding(.bottom, 10)
                               
                                HStack {
                                    WinningStack(icon: .fire, color1: colorReader(dict: storage.localPlayerWinningCardsDisplay, type: .fire, at: 0), color2: colorReader(dict: storage.localPlayerWinningCardsDisplay, type: .fire, at: 1), color3: colorReader(dict: storage.localPlayerWinningCardsDisplay, type: .fire, at: 2), local: true)
                                         
                                    WinningStack(icon: .water, color1: colorReader(dict: storage.localPlayerWinningCardsDisplay, type: .water, at: 0), color2: colorReader(dict: storage.localPlayerWinningCardsDisplay, type: .water, at: 1), color3: colorReader(dict: storage.localPlayerWinningCardsDisplay, type: .water, at: 2), local: true)
                                         
                                    WinningStack(icon: .ice, color1: colorReader(dict: storage.localPlayerWinningCardsDisplay, type: .ice, at: 0), color2: colorReader(dict: storage.localPlayerWinningCardsDisplay, type: .ice, at: 1), color3: colorReader(dict: storage.localPlayerWinningCardsDisplay, type: .ice, at: 2), local: true)
                                         
                                }
                                Spacer()
                            }
                            .frame(width: 100, height: 80)
                            .padding(.trailing, 30)
                            
                        }
                        .padding([.leading, .trailing])
                        
                        HStack(spacing: 0) {
                            CardView(card: storage.localPlayerCards[0])
                                 .frame(width: cardWidth, height: cardHeight)
                                 .onTapGesture {
                                     withAnimation() {
                                         deselectCards()
                                         
                                         if storage.currentPlayer == 1 {
                                             storage.Player1Cards[0].selected.toggle()
                                             selectedCard = storage.Player1Cards[0]
                                         } else {
                                             storage.Player2Cards[0].selected.toggle()
                                             selectedCard = storage.Player2Cards[0]
                                         }
                                         
                                         
                                         
                                     }
                                 }
                                 .offset(y: storage.localPlayerCards[0].selected ? animationAmount : 0)
                                
                                 
                            CardView(card: storage.localPlayerCards[1])
                                 .frame(width: cardWidth, height: cardHeight)
                                 .onTapGesture {
                                     withAnimation() {
                                         deselectCards()
                                         
                                         if storage.currentPlayer == 1 {
                                             storage.Player1Cards[1].selected.toggle()
                                             selectedCard = storage.Player1Cards[1]
                                         } else {
                                             storage.Player2Cards[1].selected.toggle()
                                             selectedCard = storage.Player2Cards[1]
                                         }
                                     }
                                 }
                                 .offset(y: storage.localPlayerCards[1].selected ? animationAmount : 0)
                                
                            CardView(card: storage.localPlayerCards[2])
                                 .frame(width: cardWidth, height: cardHeight)
                                 .onTapGesture {
                                     withAnimation() {
                                         deselectCards()
                                         if storage.currentPlayer == 1 {
                                             storage.Player1Cards[2].selected.toggle()
                                             selectedCard = storage.Player1Cards[2]
                                         } else {
                                             storage.Player2Cards[2].selected.toggle()
                                             selectedCard = storage.Player2Cards[2]
                                         }
                                     }
                                 }
                                 .offset(y: storage.localPlayerCards[2].selected ? animationAmount : 0)
                                 
                            CardView(card: storage.localPlayerCards[3])
                                 .frame(width: cardWidth, height: cardHeight)
                                 .onTapGesture {
                                     withAnimation() {
                                         deselectCards()
                                         if storage.currentPlayer == 1 {
                                             storage.Player1Cards[3].selected.toggle()
                                             selectedCard = storage.Player1Cards[3]
                                         } else {
                                             storage.Player2Cards[3].selected.toggle()
                                             selectedCard = storage.Player2Cards[3]
                                         }
                                     }
                                 }
                                 .offset(y: storage.localPlayerCards[3].selected ? animationAmount : 0)
                                 
                            if storage.localPlayerCards.count == 5 {
                                CardView(card: storage.localPlayerCards[4])
                                    .frame(width: cardWidth, height: cardHeight)
                                    .onTapGesture {
                                        withAnimation() {
                                            deselectCards()
                                            if storage.currentPlayer == 1 {
                                                storage.Player1Cards[4].selected.toggle()
                                                selectedCard = storage.Player1Cards[4]
                                            } else {
                                                storage.Player2Cards[4].selected.toggle()
                                                selectedCard = storage.Player2Cards[4]
                                            }
                                        }
                                    }
                                    .offset(y: storage.localPlayerCards[4].selected ? animationAmount : 0)
                                
                            }
                        }
                        .padding(8)
                    }
                }
                .padding(.bottom, 20)
                
            }
            .onAppear {
                
                if storage.savedMove[storage.messageHashValue] != nil {
                    //Do nothing
                    
                    disable = true
                    
                } else {
                
                
                if storage.localPlayerSelection != nil {
                    disable = true
                    selectedCard = storage.localPlayerSelection
                    position = .init(width: geo.size.width * localCardOffsetx, height: geo.size.height * localCardOffsety)
                    
                    
                }
                
                
                
                
                
                
                
                if storage.pastLocalPlayerSelection == nil || storage.participantsInConversasion.count > storage.maxPlayers || storage.localPlayerCurrentTurnTrue == false ? true : false || storage.localPlayerSelection != nil {
                    //do nothing
                    
                        checkForWin(0)
                    
                    
                } else {
                    disable = true
                    
                    if storage.pastRoundResult == 1 {
                        if storage.currentPlayer == 1 {
                            storage.winningSelectionsPlayer1.removeAll { value in
                                return value == storage.pastRoundselectionPlayer1
                            }
                        } else {
                            storage.winningSelectionsPlayer2.removeAll { value in
                                return value == storage.pastRoundselectionPlayer2
                            }
                        }
                    } else {
                        if storage.currentPlayer == 1 {
                            storage.winningSelectionsPlayer2.removeAll { value in
                                return value == storage.pastRoundselectionPlayer2
                            }
                        } else {
                            storage.winningSelectionsPlayer1.removeAll { value in
                                return value == storage.pastRoundselectionPlayer1
                            }
                        }
                    }
                    
                    
                   
                    
                }
            }
            }
            .onReceive(timer) { _ in
                timeActive += 0.1
                
                if storage.playBackgroundMusic == false {
                    music?.stop()
                } else if storage.playBackgroundMusic == true {
                    music?.play()
                }
                
                if timeActive > 1 && notShowedSaveMove {
                    notShowedSaveMove = false
                    
                    if let savedMoveCard = storage.savedMove[storage.messageHashValue] {
                        
                      
                            storage.selectChoice(savedMoveCard)
                            checkForRoundWin()
                        
                        print("RANSAVEDCARD!!!!!!!!!!!!")
                        selectedCard = savedMoveCard
                        
                        
                        
                        
                        
                        withAnimation() {
                            position = .init(width: geo.size.width * localCardOffsetx, height: geo.size.height * localCardOffsety)
                            isDragging = false
                            disable = true
                        }
                        
                        
                        
                        storage.scheduleWorkItem(withDelay: 1) {
                            withAnimation() {
                                offsetValueY = yPositionLocalPlayerCard - yPositionOpponentPlayerCard
                                offsetValueX = geo.size.width * opponentCardOffsetx
                                opponentCardSize = 2.58
                            }
                            
                            storage.scheduleWorkItem(withDelay: 2) {
                                withAnimation() {
                                    flipCard()
                                    
                                    if storage.currentPlayer == 1 {
                                        storage.Player1Cards.removeAll { value in
                                            var wrappedSavedMoveCard = savedMoveCard
                                            wrappedSavedMoveCard.selected = false
                                            return value == wrappedSavedMoveCard
                                        }
                                        storage.addNewCardToLocalPlayerCards()
                                    } else {
                                        storage.Player2Cards.removeAll { value in
                                            var wrappedSavedMoveCard = savedMoveCard
                                            wrappedSavedMoveCard.selected = false
                                            return value == wrappedSavedMoveCard
                                        }
                                        storage.addNewCardToLocalPlayerCards()
                                    }
                                    
                                    
                                    
                                    storage.scheduleWorkItem(withDelay: 2) {
                                        withAnimation() {
                                            offsetValueX = 0
                                            offsetValueY = 0
                                            opponentCardSize = 1
                                            position = CGSize.zero
                                            flipCard()
                                            selectedCard = nil
                                            withAnimation {
                                                storage.animationActive = true
                                            }
                                            storage.scheduleWorkItem(withDelay: storage.battleAnimationLength) {
                                                withAnimation {
                                                    storage.animationActive = false
                                                }
                                                secondTime = true
                                                disable = false
                                                
                                                withAnimation {
                                                    checkForWin(timeWaitAfterWin)
                                                }
                                                if storage.gameover {
                                                    storage.scheduleWorkItem(withDelay: timeWaitAfterWin) {
                                                        
                                                        
                                                        storage.send.toggle()
                                                        
                                                        
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                }
                            }
                        }
                        
                        
                        
                    } else {
                        
                      
                        
                        if storage.pastLocalPlayerSelection == nil || storage.participantsInConversasion.count > storage.maxPlayers || storage.localPlayerCurrentTurnTrue == false ? true : false || storage.localPlayerSelection != nil {
                            //do nothing
                          checkForWin(0)
                            
                        } else {
                            
                            //Run code here
                            withAnimation(.snappy.delay(4)) {
                                if storage.pastRoundResult == 1 {
                                    if storage.currentPlayer == 1 {
                                        storage.winningSelectionsPlayer1.append(storage.pastRoundselectionPlayer1!)
                                    } else {
                                        storage.winningSelectionsPlayer2.append(storage.pastRoundselectionPlayer2!)
                                    }
                                } else {
                                    if storage.currentPlayer == 1 {
                                        storage.winningSelectionsPlayer2.append(storage.pastRoundselectionPlayer2!)
                                    } else {
                                        storage.winningSelectionsPlayer1.append(storage.pastRoundselectionPlayer1!)
                                    }
                                }
                            }
                            
                            selectedCard = storage.pastLocalPlayerSelection
                            
                            withAnimation() {
                                position = .init(width: geo.size.width * localCardOffsetx, height: geo.size.height * localCardOffsety)
                            }
                            
                            storage.scheduleWorkItem(withDelay: 1) {
                                withAnimation() {
                                    offsetValueY = yPositionLocalPlayerCard - yPositionOpponentPlayerCard
                                    offsetValueX = geo.size.width * opponentCardOffsetx
                                    opponentCardSize = 2.58
                                }
                                
                                storage.scheduleWorkItem(withDelay: 2) {
                                    withAnimation() {
                                        flipCard()
                                        
                                        
                                        storage.scheduleWorkItem(withDelay: 2) {
                                            withAnimation() {
                                                offsetValueX = 0
                                                offsetValueY = 0
                                                opponentCardSize = 1
                                                position = CGSize.zero
                                                flipCard()
                                                selectedCard = nil
                                                withAnimation {
                                                    storage.animationActive = true
                                                }
                                                
                                                storage.scheduleWorkItem(withDelay: storage.battleAnimationLength) {
                                                    withAnimation {
                                                        storage.animationActive = false
                                                    }
                                                disable = false
                                                storage.pastRoundselectionPlayer1 = nil
                                                storage.pastRoundselectionPlayer2 = nil
                                                     withAnimation {
                                                         checkForWin(timeWaitAfterWin)
                                                     }
                                                     
                                            }
                                            }
                                        }
                                        
                                        
                                        
                                    }
                                }
                                
                                
                                
                                
                                
                                
                            }
                            
                            
                        }
                    }
                }
                
                        }
            
        }
        .onAppear {
            if storage.playBackgroundMusic {
                do {
                    let path = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3")
                    if let path = path {
                        let url = URL(fileURLWithPath: path)
                        music = try AVAudioPlayer(contentsOf: url)
                        try AVAudioSession.sharedInstance().setCategory(
                            AVAudioSession.Category.playback,
                            options: AVAudioSession.CategoryOptions.duckOthers
                        )
                        music?.setVolume(0.5, fadeDuration: 0)
                        music?.numberOfLoops =  -1
                    } else {
                        
                    }
                } catch {
                    // couldn't load file :(
                }
            }
        }
        .onDisappear {
            music?.stop()
        }
        .disabled(disable)
        
        
         
        .ignoresSafeArea()
        
        
    }

}
