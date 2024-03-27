//
//  WrappedCompact.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//

import SwiftUI

struct WrappedCompact: View {
    @EnvironmentObject var storage: AppStorage
    var body: some View {

                if storage.settingsMenuActive == true {
                    Settings()
                } else {
                    Compact()
                }
                
               
            
        
    }
}
