//
//  ContentView.swift
//  Example
//
//  Created by Sven Tiigi on 20.09.21.
//

import SwiftUI
import YouTubePlayerKit

// MARK: - ContentView

/// The ContentView
struct ContentView {

    /// The YouTube Player
    private let youTubePlayer = YouTubePlayer(
        source: .url("https://www.youtube.com/embed/3WxdD-z7-Sc")
    )
    
    /// All  WWDC Keynotes
    private let wwdcKeynotes: [WWDCKeynote] = WWDCKeynote.all.sorted(by: >)
    
    /// The color scheme
    @Environment(\.colorScheme)
    private var colorScheme
    
    @State var selectedId: UUID = UUID()
    @State var searchText: String = ""
    @State var videos: [Video] = [
        Video(title: "변수", category: "swift 문법"),
        Video(title: "버튼", category: "SwiftUI")
    ]
//    let youTubePlayer: YouTubePlayer = "https://youtube.com/watch?v=3WxdD-z7-Sc"
    
    var filteredDatas: [Video] {
        if searchText.isEmpty {
            return videos
        } else {
            return videos.filter { $0.title.localizedStandardContains(searchText) }
        }
    }
}

struct Video: Identifiable {
    let id = UUID()
    let title: String
    let category: String
}

// MARK: - View

extension ContentView: View {
    
    /// The content and behavior of the view
    var body: some View {
        NavigationSplitView {
#if os(macOS)
            List(filteredDatas, selection: $selectedId) { video in
                Text(video.title)
            }.searchable(text: $searchText, placement: .sidebar)
#elseif os(ipadOS)
            List(filteredDatas) { video in
                Text(video.title)
            }.searchable(text: $searchText, placement: .sidebar)
#endif
        } detail: {
            YouTubePlayerView(
                self.youTubePlayer,
                placeholderOverlay: {
                    ProgressView()
                }
            )
            .frame(width: 800, height: 600)
        }
    }
    
}
