//
//  VideoManagerViewModel.swift
//  FlexLog
//
//  Created by Adrian Inculet on 23.02.2026.
//

import Foundation
import AVKit

@Observable
class VideoManagerViewModel {
    let player = AVQueuePlayer()
    private var looper: AVPlayerLooper?
    var isMuted = true {
        didSet {
            player.isMuted = isMuted
        }
    }
    
    init(videoName: String, videoExtention: String = "mp4") {
        guard let url = Bundle.main.url(forResource: videoName, withExtension: videoExtention) else {
            print("Video was not found")
            return
        }
        let playerItem = AVPlayerItem(url: url)
        self.looper = AVPlayerLooper(player: player, templateItem: playerItem)
        player.isMuted = true
    }
    
    func play() { player.play() }
    func pause() { player.pause() }
    
}
