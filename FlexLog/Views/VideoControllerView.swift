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
    
    @State private var viewModel: VideoManagerViewModel
    
    init?(videoName: String, videoExtention: String = "mp4") {
        _viewModel = State(wrappedValue: VideoManagerViewModel(videoName: videoName, videoExtention: videoExtention))
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                GeometryReader { proxy in
                    VideoPlayer(player: viewModel.player)
                        .frame(width: proxy.size.width, height: 200)
                }
                .frame(height: 200)
                    Button {
                        viewModel.isMuted.toggle()
                    } label: {
                        Image(systemName: viewModel.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .padding(10)
                            .background(.white)
                            .foregroundStyle(.black)
                            .clipShape(Circle())
                            .padding(15)
                    }
                    .onAppear { viewModel.play()}
                    .onDisappear { viewModel.pause() }
            }
        }
    }
}
