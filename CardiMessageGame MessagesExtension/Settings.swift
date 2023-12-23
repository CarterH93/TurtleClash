//
//  Settings.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//


import SwiftUI

struct Settings: View {
    
    @EnvironmentObject var storage: AppStorage
    var body: some View {
        VStack {
            Text("Settings!!!")
            Button("dismiss") {
                storage.settingsMenuActive = false
                storage.goToCompactView = true
            }
        }
    }
}


