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
    var videoURL: URL?

    private var player: AVPlayer {
        return AVPlayer(url: videoURL!)
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.player = player
        controller.player?.play()
        controller.videoGravity = .resizeAspectFill
        controller.showsPlaybackControls = false
        controller.updatesNowPlayingInfoCenter = false
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: controller.player?.currentItem, queue: nil)
                { notification in
                    controller.player?.seek(to: .zero)
                    controller.player?.play()
                }
        
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {}
}





let characterAnimation = Bundle.main.url(forResource: "Animation", withExtension: "mov")

struct Animations: View {
    
    @EnvironmentObject var storage: AppStorage

    var body: some View {
        
        PlayerViewController(videoURL: characterAnimation)
            .disabled(true)
            .ignoresSafeArea()
    }
}
