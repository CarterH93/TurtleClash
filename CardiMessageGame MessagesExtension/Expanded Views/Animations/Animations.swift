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
          let object =  NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: controller.player?.currentItem, queue: nil)
                    { notification in
                        controller.player?.seek(to: .zero)
                        controller.player?.play()
                    }
            storage.createdObservers.append(object)
        }
        
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {}
}







struct Animations: View {
    
    @EnvironmentObject var storage: AppStorage

    var animationURL: URL {
        if storage.animationActive {
            if storage.pastRoundResult == 1 {
                return Bundle.main.url(forResource: "\(storage.pastLocalPlayerSelection!.type.rawValue)\(storage.pastLocalPlayerSelection!.animation)local", withExtension: "mov")!
            } else {
                return Bundle.main.url(forResource: "\(storage.pastRemotePlayerSelection!.type.rawValue)\(storage.pastRemotePlayerSelection!.animation)remote", withExtension: "mov")!
            }
           
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
