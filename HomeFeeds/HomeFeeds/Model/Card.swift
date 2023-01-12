//
//  Card.swift
//  HomeFeeds
//
//  Created by Andrew Ikenna Jones on 1/12/23.
//

import Foundation

enum CardType: Codable {
   case text
   case titleDescription
   case imageTitleDescription
   case other

   init(from decoder: Decoder) throws {
      let label = try decoder.singleValueContainer().decode(String.self)
      switch label {
        case "title_description": self = .titleDescription
        case "image_title_description": self = .imageTitleDescription
        case "text": self = .text
        default: self = .other
      }
   }
}

struct Card: Codable {
    let cardType: CardType
    let card: CardContents
}

enum CardContents: Codable {
    case singleText(TextElement)
    case multi(CombinedElements)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let v = try? container.decode(TextElement.self) {
            self = .singleText(v)
            return
        }
        if let v = try? container.decode(CombinedElements.self) {
            self = .multi(v)
            return
        }
        throw DecodingError.typeMismatch(
                CardContents.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Type is not matched", underlyingError: nil))
        }
}
