//
//  HomeFeedsService.swift
//  HomeFeeds
//
//  Created by Andrew Ikenna Jones on 1/11/23.
//

import Foundation

protocol FeedsService_Protocol {
    func homeFeedCards(completion: @escaping (Result<[Card], Error>) -> Void)
}

class FeedsService: FeedsService_Protocol {
    private let httpClient: HttpClient
    private let jsonDecoder: JSONDecoder
    
    enum FeedsServiceError: Error {
        case invalidUrl
    }
    
    struct HomeFeedsResponseBody: Codable {
        let page: HomeFeedCards
    }
    
    struct HomeFeedCards: Codable {
        let cards: [Card]
    }

    init() {
        self.httpClient = HttpClient(session: URLSession.shared)
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func homeFeedCards(completion: @escaping (Result<[Card], Error>) -> Void) {
        guard let url = URL(string: FeedsAPI.homeFeedsURL) else {
            completion(.failure(FeedsServiceError.invalidUrl))
            return
        }
        print(url.absoluteString)
                
        httpClient.get(url: url) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(HttpClientError.emptyData))
                return
            }
            do {
                let result = try self.jsonDecoder.decode(HomeFeedsResponseBody.self, from: data)
                completion(.success(result.page.cards))
            } catch {
                completion(.failure(error))
            }
        }
    }
}


