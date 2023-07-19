//
//  WWDCKeynote.swift
//  Example
//
//  Created by Sven Tiigi on 21.09.21.
//

import Foundation

// MARK: - WWDCKeynote

import Foundation

// MARK: - CurriculumRoadmap

struct Content: Identifiable {
    let id = UUID()
    let contentType: ContentType
    var roadMaps: [CurriculumRoadmap]? = nil
}

enum ContentType {
    case home
    case course
}

struct CurriculumRoadmap: Codable, Hashable, Identifiable, Comparable {
    
    let curriculumId: Int
    let course: Course
    let videos: [Video]
    var id: String = UUID().uuidString // Moved into the main structure
    
    // Comparable protocol
    static func < (lhs: CurriculumRoadmap, rhs: CurriculumRoadmap) -> Bool {
        lhs.id < rhs.id
    }
    
    // Nested enum
    enum Course: Codable {
        case eightDaysBasic
        case allSwift
        case dailySwiftUI
        
        var displayName: String {
            switch self {
            case .eightDaysBasic:
                return "8일만에 시작하는 iOS앱의 첫 걸음"
            case .allSwift:
                return "SwiftUI로 배우는 Swift 문법"
            case .dailySwiftUI:
                return "매일매일 공부하는 SwiftUI"
            }
        }
    }
    
    // Predefined constants
    static let all: [Self] = [
        .sevenDaysBasic,
        .allSwift,
        .dailySwiftUI,
        //.test
    ]
}

// MARK: - Video

struct Video: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let URLString: String
    let fileName: String
    
    init(title: String, URLString: String, fileName: String) {
        self.id = Video.getUniqueID()
        self.title = title
        self.URLString = "https://www.youtube.com/watch?v= " + URLString
        self.fileName = fileName
    }
    
    static func getUniqueID() -> Int {
        idGenerator += 1
        return idGenerator
    }
    
    private static var idGenerator: Int = 0 // Encapsulate idGenerator
}

// MARK: - Predefined CurriculumRoadmaps

extension CurriculumRoadmap {
    
    static let sevenDaysBasic: Self = .init(
        curriculumId: 0,
        course: .eightDaysBasic,
        videos: [
            Video(title: "#0 iOS 독학을 시작하기 전에 보면 좋은 이야기",
                  URLString: "dGKnR4kvnsc",
                  fileName: "01"),
            Video(title: "#1 Xcode 설치",
                  URLString: "yGvzJZNcfa0",
                  fileName: "01"),
            Video(title: "#2 프로젝트 생성",
                  URLString: "1jsRoFomNJE",
                  fileName: "01"),
            Video(title: "#3 Xcode라는 IDE에 대해 알아보자",
                  URLString: "r7WRoZCbj8M",
                  fileName: "01"),
        ]
    )
    
    static let allSwift: Self = .init(
        curriculumId: 1,
        course: .allSwift,
        videos: [
            Video(title: "변수 #1 - 변수 왜 그리고 어떻게 쓰는가?",
                  URLString: "dGKnR4kvnsc",
                  fileName: "01"),
            Video(title: "변수 #2 - 변수의 종류는?",
                  URLString: "fsh-YzZwymA",
                  fileName: "01"),
            Video(title: "변수 #3 - 연산자란?",
                  URLString: "_FH856MCYik",
                  fileName: "01"),
            Video(title: "변수 #4 - 여러개의 변수를 모아서 쓰는 콜렉션 타입",
                  URLString: "qkGraBVTVZI",
                  fileName: "01"),
            
        ]
    )
    
    static let dailySwiftUI: Self = .init(
        curriculumId: 2,
        course: .dailySwiftUI,
        videos: [
            Video(title: "#1 눌러서 쓰는 Button 사용해보기",
                  URLString: "jW_LiiWshs0",
                  fileName: "01"),
            Video(title: "#2 글자를 보여주는 Text 사용해보기",
                  URLString: "i6xlF_GgwkY",
                  fileName: "01"),
            Video(title: "#3 Image는 어떻게 추가해요?",
                  URLString: "8lJO3akGZLM",
                  fileName: "01"),
            Video(title: "#4 Stack으로 쌓아보아요! VStack, HStack, ZStack",
                  URLString: "BM1M4lzATYY",
                  fileName: "01"),
        ]
    )
}
