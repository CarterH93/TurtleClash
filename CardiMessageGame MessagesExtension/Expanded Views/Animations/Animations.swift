//
//  Animations.swift
//  CardiMessageGame MessagesExtension
//
//  Created by Carter Hawkins on 1/21/24.
//

import SwiftUI
import SpriteKit
import AVKit


struct PlayerViewController: UIViewControllerRepresentable {
    
    @EnvironmentObject var storage: AppStorage
    var animationURL: URL
    
    let idleAnimationLength: Double = 4

    private var player: AVPlayer {
        return AVPlayer(url: animationURL)
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.player = player
        controller.player?.play()
        controller.videoGravity = .resizeAspectFill
        controller.showsPlaybackControls = false
        controller.updatesNowPlayingInfoCenter = false
        if storage.animationActive == false {
            storage.scheduleWorkItem(withDelay: idleAnimationLength) {
                
                controller.player?.seek(to: .zero)
                controller.player?.play()
                
            }
        }
        
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {}
}







struct Animations: View {
    
    @EnvironmentObject var storage: AppStorage

    var animationURL: URL {
        if storage.animationActive {
            return Bundle.main.url(forResource: "fire1local", withExtension: "mov")!
        } else {
            return Bundle.main.url(forResource: "idle", withExtension: "mov")!
        }
        
        
    }
    
    var body: some View {
        ZStack {
            if storage.animationActive {
                PlayerViewController(animationURL: animationURL)
                    .disabled(true)
                    .ignoresSafeArea()
            } else {
                PlayerViewController(animationURL: animationURL)
                    .disabled(true)
                    .ignoresSafeArea()
            }
        }
        
    }
}
