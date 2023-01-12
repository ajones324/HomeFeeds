//
//  Elements.swift
//  HomeFeeds
//
//  Created by Andrew Ikenna Jones on 1/12/23.
//

import Foundation
struct TextElement: Codable {
    let value: String
    let attributes: TextAttributes
}

struct ImageElement: Codable {
    let url: String
    let size: ImageSize
}

struct CombinedElements: Codable {
    let title: TextElement?
    let description: TextElement?
    let image: ImageElement?
}
