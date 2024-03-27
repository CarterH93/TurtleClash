//
//  Expanded.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//

import SwiftUI
//Information bridge to UIkit
//https://youtu.be/CNhcAz40Myw
//https://www.youtube.com/watch?v=Ent5zMwt-h4&t=0s

struct Expanded: View {
    
    
    @State private var size = 1.0
    @EnvironmentObject var storage: AppStorage
    
    @State private var type: type = .fire
    @State private var color: color = .blue
    @State private var number = 1
    @State private var animation = 1
   
    var body: some View {
    
    Gameplay()
    
    }
}


//The previews for SwiftUI are not supported


