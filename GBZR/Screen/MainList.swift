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
    @Environment(\.colorScheme)
    private var colorScheme
    
    @State var selectedId: Int = -1
    @State var searchText: String = ""
    @State var contents: [Content] = [Content(contentType: .home),
                                      Content(contentType: .course,
                                              roadMaps: CurriculumRoadmap.all)]
    @State var roadmaps: [CurriculumRoadmap] = CurriculumRoadmap.all
    
    var filteredDatas: [CurriculumRoadmap] {
        if searchText.isEmpty {
            return roadmaps
        } else {
            return roadmaps.filter { $0.course.displayName.localizedStandardContains(searchText) }
        }
    }
}
// MARK: - View

extension MainList: View {
    var body: some View {
        NavigationSplitView {
#if os(macOS)
            List(contents, selection: $selectedId) { content in
                
                switch content.contentType {
                case .home :
                    Section("홈") {
                        Text("홈")
                            .tag(-1)
                    }
                case .course :
                    Section("강의") {
                        ForEach(filteredDatas, id: \.self) { curriculum in
                            Text(curriculum.course.displayName)
                                .tag(curriculum.curriculumId)
                        }
                    }
                }
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
        if selectedId > -1 {
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
                            
                            
                            MarkdownLeeo(fileName: video.fileName)
                        }
                        .frame(width: 700)
                    } label: {
                        HStack {
                            Text(video.title)
                                .frame(height: 40, alignment: .leading)
                                .font(.title3)
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    .frame(minWidth: 500)
                    .listRowBackground(video.id % 2 == 0 ? Color.gray.opacity(0.1) : Color.clear)
                }
            }
        }
        else {
            HomeView()
        }
    }
    }
}
