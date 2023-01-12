//
//  Attributes.swift
//  HomeFeeds
//
//  Created by Andrew Ikenna Jones on 1/12/23.
//

import Foundation

typealias HexColorCode = String

struct TextAttributes: Codable {
    let textColor: HexColorCode
    let font: FontAttributes
}

struct FontAttributes: Codable {
    let size: Double
}

struct ImageSize: Codable {
    let width: Double
    let height: Double
}
