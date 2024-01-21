//
//  Animations.swift
//  CardiMessageGame MessagesExtension
//
//  Created by Carter Hawkins on 1/21/24.
//

import SwiftUI
import SpriteKit
import AVKit

let characterAnimation = Bundle.main.url(forResource: "idle", withExtension: "mov")
let backgroundAnimation = Bundle.main.url(forResource: "background", withExtension: "mov")
struct Animations: View {
    
    var geo: GeometryProxy

   var videoPlayer = AVPlayer(url: backgroundAnimation!)
    
   
    var videoPlayer2 = AVPlayer(url: characterAnimation!)
    func scene(_ geo: GeometryProxy) -> SKScene {
        // Load the SKScene from 'backgroundScene.sks'
       let scene = SKScene(fileNamed: "backgroundScene")
            
      
        
    
        
        let video = SKVideoNode(avPlayer: videoPlayer)
        video.size = CGSize(width: geo.size.height * 1.21626297578, height: geo.size.height)
        scene!.addChild(video)
        videoPlayer.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                                       object: videoPlayer.currentItem, queue: nil)
                { notification in
                    self.videoPlayer.seek(to: .zero)
                    self.videoPlayer.play()
                }
        
        let video2 = SKVideoNode(avPlayer: videoPlayer2)
        video2.size = CGSize(width: geo.size.height * 1.21626297578, height: geo.size.height)
        //Ability to mirror video
        //video2.xScale = -1.0
        scene!.addChild(video2)
        videoPlayer2.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                                       object: videoPlayer2.currentItem, queue: nil)
                { notification in
                    self.videoPlayer2.seek(to: .zero)
                    self.videoPlayer2.play()
                }
        
        scene!.size = CGSize(width: geo.size.height * 1.21626297578, height: geo.size.height)
    
        return scene!
    }

    var body: some View {
       
        
            SpriteView(scene: scene(geo))
            .ignoresSafeArea()
        
    }
}
