//
//  Card.swift
//  CardiMessageGame MessagesExtension
//
//  Created by Carter Hawkins on 12/23/23.
//

import Foundation
import SwiftUI

enum type: String, CaseIterable {
    case fire
    case water
    case ice
}

enum color: String, CaseIterable {
    case blue
    case orange
    case green
}

struct Card: Hashable {
    var number: Int
    var type: type
    var color: color
    var animation: Int
    var selected = false
    
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
    
    var convertColorToRealColor: Color {
        switch color {
        case .blue:
            return .blue
        case .orange:
            return . orange
        case .green:
            return .green
        }
    }
}


func colorConverter(_ color: color?) -> Color? {
    switch color {
    case .blue:
        return .blue
    case .orange:
        return .orange
    case .green:
        return .green
    default:
        return nil
    }
}
