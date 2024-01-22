//
//  Animations.swift
//  CardiMessageGame MessagesExtension
//
//  Created by Carter Hawkins on 1/21/24.
//

import SwiftUI
import SpriteKit
import AVKit

let characterAnimation = Bundle.main.url(forResource: "idle-1", withExtension: "mov")

struct Animations: View {
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var timeActive = 0.0
    @State private var lastHeight: Double? = nil
    @State private var hideAnimation = false
    
    

   
   
    
    
   
    var videoPlayer = AVPlayer(url: characterAnimation!)
    func scene(_ geo: GeometryProxy) -> SKScene {
        // Load the SKScene from 'backgroundScene.sks'
       let scene = SKScene(fileNamed: "backgroundScene")
            
      
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = CGSize(width: geo.size.height * 0.82219061166, height: geo.size.height)
        scene!.addChild(background)
       
        let video = SKVideoNode(avPlayer: videoPlayer)
        video.size = CGSize(width: geo.size.height * 0.82219061166, height: geo.size.height)
        //Ability to mirror video
        //video2.xScale = -1.0
        scene!.addChild(video)
        videoPlayer.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                                       object: videoPlayer.currentItem, queue: nil)
                { notification in
                    self.videoPlayer.seek(to: .zero)
                    self.videoPlayer.play()
                }
        
        scene!.size = CGSize(width: geo.size.height * 0.82219061166, height: geo.size.height)
    
        return scene!
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                if !hideAnimation {
                    SpriteView(scene: scene(geo))
                        .ignoresSafeArea()
                }
            }
            .onReceive(timer) { _ in
                timeActive += 0.1
                 
                
                if lastHeight != nil {
                    if geo.size.height != lastHeight {
                        timeActive = 0.0
                        hideAnimation = true
                    } else {
                        if timeActive > 0.5 {
                            timeActive = 0.0
                            hideAnimation = false
                            videoPlayer.play()
                        }
                    }
                }
                
                
                lastHeight = geo.size.height
            }
        }
    }
}
