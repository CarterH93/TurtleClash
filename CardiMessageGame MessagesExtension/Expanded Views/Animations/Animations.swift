//
//  Animations.swift
//  CardiMessageGame MessagesExtension
//
//  Created by Carter Hawkins on 1/21/24.
//

import SwiftUI
import SpriteKit
import AVKit

let characterAnimation = Bundle.main.url(forResource: "fire1-1", withExtension: "mov")

struct Animations: View {
    
    var geo: GeometryProxy

   
   
    
    
   
    var videoPlayer = AVPlayer(url: characterAnimation!)
    func scene(_ geo: GeometryProxy) -> SKScene {
        // Load the SKScene from 'backgroundScene.sks'
       let scene = SKScene(fileNamed: "backgroundScene")
            
      
        
        var background = SKSpriteNode(imageNamed: "background")
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
       
        
            SpriteView(scene: scene(geo))
            .ignoresSafeArea()
        
        
    }
}
