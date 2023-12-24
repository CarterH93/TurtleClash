//
//  Card.swift
//  CardiMessageGame MessagesExtension
//
//  Created by Carter Hawkins on 12/23/23.
//

import Foundation

enum type: String {
    case fire
    case water
    case ice
}

enum color: String {
    case blue
    case orange
    case green
}

struct Card {
    var number: Int
    var type: type
    var color: color
    var animation: Int
    
    var typeNum: Int {
        switch type {
        case .fire:
            return 1
        case .water:
            return 2
        case .ice:
            return 3
        }
    }
    
    var colorNum: Int {
        switch color {
        case .blue:
            return 1
        case .orange:
            return 2
        case .green:
            return 3
        }
    }
    
    var description: String {
        return "number: \(String(number))  |  type: \(type.rawValue)  |  color: \(color.rawValue)  |  animation: \(String(animation))"
    }
}
