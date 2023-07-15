//
//  WWDCKeynote.swift
//  Example
//
//  Created by Sven Tiigi on 21.09.21.
//

import Foundation

// MARK: - WWDCKeynote

/// An  WWDC Keynote
struct CurriculumRoadmap: Codable, Hashable {
    
    let curriculumId: Int
    /// The year
    let course: Course
    
    /// The YouTube URL
    let videos: [Video]
    
    enum Course: Codable {
        case eightDaysBasic
        case test
        
        var displayName: String {
            switch self {
            case .eightDaysBasic:
                return "8일만에 시작하는 iOS앱의 첫 걸음"
            case .test:
                return "케이스 테스트 입니다"
            }
            
        }
    }
}

// MARK: - Identifable

extension CurriculumRoadmap: Identifiable {
    
    /// The stable identity of the entity associated with this instance.
    var id: String {
        return UUID().uuidString
    }
    
}

// MARK: - Comparable

extension CurriculumRoadmap: Comparable {
    
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func < (
        lhs: Self,
        rhs: Self
    ) -> Bool {
        // 이상한 부분
        lhs.id < rhs.id
    }
    
}

// MARK: - All Keynotes

extension CurriculumRoadmap {
    
    static let all: [Self] = [
        .eightDaysBasic,
        .test
        //        .wwdc2014,
        //        .wwdc2015,
        //        .wwdc2016,
        //        .wwdc2017,
        //        .wwdc2018,
        //        .wwdc2019,
        //        .wwdc2020,
        //        .wwdc2021,
        //        .wwdc2022
    ]
    
}

// MARK: - Keynotes from 2014 to 2021

struct Video: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let URLString: String
}

extension CurriculumRoadmap {

    static let eightDaysBasic: Self = .init(
        curriculumId: 0,
        course: .eightDaysBasic,
        videos: [
            Video(id: 0, title: "#0 iOS 독학을 시작하기 전에 보면 좋은 이야기", URLString: "https://www.youtube.com/watch?v=dGKnR4kvnsc"),
            Video(id: 1, title: "#1 Xcode 설치", URLString: "https://www.youtube.com/watch?v=yGvzJZNcfa0"),
            Video(id: 2, title: "#2 프로젝트 생성", URLString: "https://www.youtube.com/watch?v=1jsRoFomNJE"),
            Video(id: 3, title: "#3 Xcode라는 IDE에 대해 알아보자", URLString: "https://www.youtube.com/watch?v=r7WRoZCbj8M"),
        ]
    )
    
    static let test: Self = .init(
        curriculumId: 1,
        course: .test,
        videos: [Video(id: 0, title: "#1 Xcode 설치123", URLString: "https://www.youtube.com/watch?v=yGvzJZNcfa0"),
                 Video(id: 1, title: "#2 프로젝트 생성123", URLString: "id://www.youtube.com/watch?v=1jsRoFomNJE"),
                 Video(id: 2, title: "#3 Xcode라는 IDE에 대해 알아보자123", URLString: "https://www.youtube.com/watch?v=r7WRoZCbj8M"),
                ]
    )
    //
    //    static let wwdc2015: Self = .init(
    //        year: 2015,
    //        youTubeURL: "https://www.youtube.com/watch?v=_p8AsQhaVKI"
    //    )
    //
    //    static let wwdc2016: Self = .init(
    //        year: 2016,
    //        youTubeURL: "https://www.youtube.com/watch?v=n5jXg_NNiCA"
    //    )
    //
    //    static let wwdc2017: Self = .init(
    //        year: 2017,
    //        youTubeURL: "https://www.youtube.com/watch?v=oaqHdULqet0"
    //    )
    //
    //    static let wwdc2018: Self = .init(
    //        year: 2018,
    //        youTubeURL: "https://www.youtube.com/watch?v=UThGcWBIMpU"
    //    )
    //
    //    static let wwdc2019: Self = .init(
    //        year: 2019,
    //        youTubeURL: "https://youtube.com/watch?v=3WxdD-z7-Sc"
    //    )
    //
    //    static let wwdc2020: Self = .init(
    //        year: 2020,
    //        youTubeURL: "https://www.youtube.com/watch?v=GEZhD3J89ZE"
    //    )
    //
    //    static let wwdc2021: Self = .init(
    //        year: 2021,
    //        youTubeURL: "https://www.youtube.com/watch?v=0TD96VTf0Xs"
    //    )
    //
    //    static let wwdc2022: Self = .init(
    //        year: 2022,
    //        youTubeURL: "https://www.youtube.com/watch?v=q5D55G7Ejs8"
    //    )
    //
}
