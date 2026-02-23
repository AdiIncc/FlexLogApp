//
//  VideoControllerView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 23.02.2026.
//

import Foundation
import SwiftUI
import AVKit

struct VideoControllerView: View {
    private var player = AVQueuePlayer()
    private var looper: AVPlayerLooper?
    @State private var isMuted = true
    
    init?(videoName: String, videoExtention: String = "mp4") {
        guard let url = Bundle.main.url(forResource: videoName, withExtension: videoExtention) else {
            print("Video was not found")
            return
        }
        let playerItem = AVPlayerItem(url: url)
        self.looper = AVPlayerLooper(player: player, templateItem: playerItem)
        player.isMuted = true
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                GeometryReader { proxy in
                    VideoPlayer(player: player)
                        .frame(width: proxy.size.width, height: 200)
                }
                .frame(height: 200)
                    Button {
                        isMuted.toggle()
                        player.isMuted = isMuted
                    } label: {
                        Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .padding(10)
                            .background(.white)
                            .foregroundStyle(.black)
                            .clipShape(Circle())
                            .padding(15)
                    }
                
                
                .onAppear { player.pause() }
                .onDisappear { player.pause() }
            }
        }
    }
}
