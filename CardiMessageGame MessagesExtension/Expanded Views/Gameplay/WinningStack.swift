//
//  WinningStack.swift
//  iMessage Playground
//
//  Created by Carter Hawkins on 12/25/23.
//

import SwiftUI



struct WinningStack: View {
    
    
    @EnvironmentObject var storage: AppStorage
    
    var icon: type
    var color1: color?
    var color2: color?
    var color3: color?
    var local: Bool
    
    var scaleEffect: CGFloat = 2
    
    
    

    func sameCardTypeWithMultipleColors(color: color?) -> Bool {
        if local {
            if let color = color {
                if let array = storage.localPlayerWinningCardsAnimated[icon] {
                    if array.contains(color) {
                        if let array = storage.localPlayerWinningCardsAnimated[icon] {
                            if array.count > 2 {
                                return true
                            }
                        }
                    }
                }
            }
        } else {
            if let color = color {
                if let array = storage.remotePlayerWinningCardsAnimated[icon] {
                    if array.contains(color) {
                        if let array = storage.remotePlayerWinningCardsAnimated[icon] {
                            if array.count > 2 {
                                return true
                            }
                        }
                    }
                }
            }
        }
        return false
    }
    
    
    func winningCardPos(color: color?) -> CGSize {
        if local {
            
            if let color = color {
                if let array = storage.localPlayerWinningCardsAnimated[icon] {
                    if array.contains(color) {
                        
                        if sameCardTypeWithMultipleColors(color: color) {
                            switch icon {
                            case .fire:
                                return .init(width: -25, height: -150)
                            case .water:
                                return .init(width: -50, height: -150)
                            case .ice:
                                return .init(width: -75, height: -150)
                            }
                           
                        } else {
                            switch icon {
                            case .fire:
                                return .init(width: -70, height: -150)
                            case .water:
                                return .init(width: -50, height: -150)
                            case .ice:
                                return .init(width: -30, height: -150)
                            }
                        }
                        
                        
                    }
                }
            }
           
            
            
        } else {
            
            if let color = color {
                if let array = storage.remotePlayerWinningCardsAnimated[icon] {
                    if array.contains(color) {
                        
                        if sameCardTypeWithMultipleColors(color: color) {
                            
                            switch icon {
                            case .fire:
                                return .init(width: 80, height: 150)
                            case .water:
                                return .init(width: 60, height: 150)
                            case .ice:
                                return .init(width: 35, height: 150)
                            }
                           
                        } else {
                            switch icon {
                            case .fire:
                                return .init(width: 30, height: 150)
                            case .water:
                                return .init(width: 55, height: 150)
                            case .ice:
                                return .init(width: 80, height: 150)
                            }
                        }
                        
                        
                    }
                }
            }
            
            
        }
        
        
        
        return CGSize.zero
    }
    
    
    var body: some View {
           
                ZStack {
                    
                    if let color = colorConverter(color3) {
                        ZStack {
                            Color(.init(color))
                            Image(icon.rawValue)
                                .resizable()
                                .scaledToFit()
                                .padding(3)
                                .opacity(winningCardPos(color: color3).height != 0 ? 1 : 0)
                        }
                        .frame(width: 40, height: 30)
                        .offset(x: winningCardPos(color: color3).width + (sameCardTypeWithMultipleColors(color: color3) ? 50 : 0), y: winningCardPos(color: color3).height != 0 ? winningCardPos(color: color3).height : 20)
                        .scaleEffect(winningCardPos(color: color3).height != 0 ? scaleEffect : 1)
                    }
                   
                    if let color = colorConverter(color2) {
                        
                        if let aboveColor = colorConverter(color1) {
                            ZStack {
                                Color(.init(color))
                                Image(icon.rawValue)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(3)
                                    .opacity(winningCardPos(color: color2).height != 0 || winningCardPos(color: color1).height != 0 ? 1 : 0 )
                            }
                            .frame(width: 40, height: 30)
                            
                            
                            .offset(x: winningCardPos(color: color2).width, y: winningCardPos(color: color2).height != 0 ? winningCardPos(color: color2).height : 10)
                            .scaleEffect(winningCardPos(color: color2).height != 0 ? scaleEffect : 1)
                            
                            
                        } else {
                            
                            if let aboveColor = colorConverter(color1) {
                                ZStack {
                                    Color(.init(color))
                                    Image(icon.rawValue)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(3)
                                        .opacity(winningCardPos(color: color2).height != 0 ? 1 : 0 )
                                }
                                .frame(width: 40, height: 30)
                                
                                
                                .offset(x: winningCardPos(color: color2).width, y: winningCardPos(color: color2).height != 0 ? winningCardPos(color: color2).height : 10)
                                .scaleEffect(winningCardPos(color: color2).height != 0 ? scaleEffect : 1)
                                
                            }
                            
                        }
                    }
                    
                    
                    if let color = colorConverter(color1) {
                        ZStack {
                            Color(.init(color))
                            Image(icon.rawValue)
                                .resizable()
                                .scaledToFit()
                                .padding(3)
                                
                            
                        }
                        .frame(width: 40, height: 30)
                        
                        .offset(x: winningCardPos(color: color1).width + (sameCardTypeWithMultipleColors(color: color1) ? -50 : 0), y: winningCardPos(color: color1).height != 0 ? winningCardPos(color: color1).height : 0)
                        .scaleEffect(winningCardPos(color: color1).height != 0 ? scaleEffect : 1)
                    }
                    
                
               
               
                
                
            
            
            
            
        }
    }
}
/*
#Preview {
    WinningStack(icon: "fire", color1: .blue, color2: .green, color3: .orange)
}
*/
