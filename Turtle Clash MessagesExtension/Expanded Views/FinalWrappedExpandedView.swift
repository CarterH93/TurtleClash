//
//  FinalWrappedExpanded.swift
//  IMessageGameTemplate MessagesExtension
//
//  Created by Carter Hawkins on 5/23/23.
//

import SwiftUI

struct FinalWrappedExpanded: View {
    
    @EnvironmentObject var storage: AppStorage
    var body: some View {
        GeometryReader { geo in
            if storage.settingsMenuActive == false {
                    WrappedExpanded()
            }
            if geo.size.height > geo.size.width {
                
                
                if storage.settingsMenuActive == true {
                        Settings()
                        
                    
                    
                }
            } else {
                ZStack {
                    Color.black.ignoresSafeArea()
                    VStack {
                        Image("Rotate")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.primary)
                            .frame(width: geo.size.width / 2, height: geo.size.height / 3)
                        
                        Text("Please Rotate to Portrait")
                            .font(.title)
                        
                    }
                    
                    .frame(width: geo.size.width, height: geo.size.width)
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            
        }
    }
}
