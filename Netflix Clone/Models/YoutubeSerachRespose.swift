//
//  YoutubeSerachRespose.swift
//  Netflix Clone
//
//  Created by Erat on 16.07.2023.
//

import Foundation

struct YoutubeSearchRespose: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
