//
//  Gameplay.swift
//  iMessage Playground
//
//  Created by Carter Hawkins on 12/25/23.
//

import SwiftUI

struct Gameplay: View {
    
    
    
    
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
    
    
    let cardWidth: CGFloat = 75
    
    let cardHeight: CGFloat = 115
    
    let animationAmount: CGFloat = -20
    
    @State var disable = false
    
    @State var isDragging = false
    @State var position = CGSize.zero
    @State var opponentCardPosition = CGSize.zero
    @State var opponentCardSize: CGFloat = 1
    
  @State private var cards = [Card(number: 1, type: .fire, color: .blue, animation: 1), Card(number: 3, type: .water, color: .green, animation: 1), Card(number: 2, type: .ice, color: .orange, animation: 1), Card(number: 9, type: .fire, color: .orange, animation: 1), Card(number: 6, type: .ice, color: .blue, animation: 1)]
    
    @State private var selectedCard: Card? = nil
    
    func deselectCards() {
        var hold: [Card] = []
        for card in cards {
            var temp = card
            temp.selected = false
            hold.append(temp)
        }
        cards = hold
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
                Image("Desig")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                
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
                                        CardView(card: Card(number: 1, type: .fire, color: .orange, animation: 1))
                                            .frame(width: cardWidth / 2, height: cardHeight / 2)
                                            .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
                                    }
                                    .offset(x: opponentCardPosition.width, y: opponentCardPosition.height)
                                    .scaleEffect(opponentCardSize)
                                    
                                    
                                    
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
                            if let selectedCard = selectedCard {
                                CardView(card: selectedCard)
                                    .frame(width: cardWidth * 1.3, height: cardHeight * 1.3)
                                    .padding()
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
                                                
                                                
                                                
                                                withAnimation() {
                                                    position = .init(width: geo.size.width * 0, height: -geo.size.height * 0.3)
                                                    isDragging = false
                                                    disable = true
                                                }
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                        withAnimation() {
                                                            opponentCardPosition =  .init(width: geo.size.width * 0.05, height: geo.size.height * 0.103)
                                                            opponentCardSize = 2.58
                                                        }
                                                        
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                                            withAnimation() {
                                                                flipCard()
                                                                storage.selectChoice(selectedCard)
                                                                storage.send.toggle()
                                                            }
                                                        })
                                                    })
                                                    
                                                
                                            })
                                )
                                    .ignoresSafeArea(.all)
                            } else {
                                EmptyCard()
                                    .frame(width: cardWidth * 1.3, height: cardHeight * 1.3)
                                    .padding()
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
                            CardView(card: cards[0])
                                 .frame(width: cardWidth, height: cardHeight)
                                 .onTapGesture {
                                     withAnimation() {
                                         deselectCards()
                                         cards[0].selected.toggle()
                                         selectedCard = cards[0]
                                     }
                                 }
                                 .offset(y: cards[0].selected ? animationAmount : 0)
                                
                                 
                            CardView(card: cards[1])
                                 .frame(width: cardWidth, height: cardHeight)
                                 .onTapGesture {
                                     withAnimation() {
                                         deselectCards()
                                         cards[1].selected.toggle()
                                         selectedCard = cards[1]
                                     }
                                 }
                                 .offset(y: cards[1].selected ? animationAmount : 0)
                                
                            CardView(card: cards[2])
                                 .frame(width: cardWidth, height: cardHeight)
                                 .onTapGesture {
                                     withAnimation() {
                                         deselectCards()
                                         cards[2].selected.toggle()
                                         selectedCard = cards[2]
                                     }
                                 }
                                 .offset(y: cards[2].selected ? animationAmount : 0)
                                 
                            CardView(card: cards[3])
                                 .frame(width: cardWidth, height: cardHeight)
                                 .onTapGesture {
                                     withAnimation() {
                                         deselectCards()
                                         cards[3].selected.toggle()
                                         selectedCard = cards[3]
                                     }
                                 }
                                 .offset(y: cards[3].selected ? animationAmount : 0)
                                 
                            CardView(card: cards[4])
                                 .frame(width: cardWidth, height: cardHeight)
                                 .onTapGesture {
                                     withAnimation() {
                                         deselectCards()
                                         cards[4].selected.toggle()
                                         selectedCard = cards[4]
                                     }
                                 }
                                 .offset(y: cards[4].selected ? animationAmount : 0)
                                 
                            
                        }
                        .padding(8)
                    }
                }
                .padding(.bottom, 20)
                
            }
            
        }
        .disabled(disable ? true : false)
        .ignoresSafeArea()
        
    }

}

