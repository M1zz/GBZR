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
struct MainList {
    
    /// The YouTube Player
    //    private let youTubePlayer = YouTubePlayer(
    //        source: .url("https://www.youtube.com/embed/3WxdD-z7-Sc")
    //    )
    
    /// All  WWDC Keynotes
    private let wwdcKeynotes: [CurriculumRoadmap] = CurriculumRoadmap.all.sorted(by: >)
    
    /// The color scheme
    @Environment(\.colorScheme)
    private var colorScheme
    
    @State var selectedId: Int = 0
    @State var searchText: String = ""
    @State var roadmaps: [CurriculumRoadmap] = CurriculumRoadmap.all
    
    var filteredDatas: [CurriculumRoadmap] {
        if searchText.isEmpty {
            return roadmaps
        } else {
            return roadmaps.filter { $0.course.displayName.localizedStandardContains(searchText) }
        }
    }
}

//struct Video: Identifiable {
//    let id = UUID()
//    let title: String
//    let category: String
//}

// MARK: - View

extension MainList: View {
    var body: some View {
        NavigationSplitView {
#if os(macOS)
            List(filteredDatas, selection: $selectedId) { curriculum in
                Text(curriculum.course.displayName)
                    .tag(curriculum.curriculumId)
                    .frame(alignment: .leading)
            }
            .searchable(text: $searchText, placement: .sidebar)
            .navigationSplitViewColumnWidth(min: 200 ,ideal: 300, max: 400)
#elseif os(iOS)
            List(filteredDatas) { curriculum in
                Text(curriculum.course.displayName)
            }.searchable(text: $searchText, placement: .sidebar)
#endif
        }
        
    detail: {
            NavigationStack {
                List(roadmaps[selectedId].videos) { video in
                    NavigationLink {
                        VStack {
                            YouTubePlayerView(
                                
                                YouTubePlayer(
                                    source: .url(video.URLString)
                                ),
                                placeholderOverlay: {
                                    ProgressView()
                                }
                            )
                            
                            
                            MarkdownLeeo()
                        }
                        .frame(width: 700)
                    } label: {
                        Text(video.title)
                    }
                }
            }
        }
    }
    
}
