//
//  HomeFeedsViewModel.swift
//  HomeFeeds
//
//  Created by Andrew Ikenna Jones on 1/12/23.
//

import Foundation
import Combine

final class HomeFeedsViewModel: ObservableObject {
    let apiService: FeedsService
    @Published private(set) var cards: [Card]
    var title: String

    init(apiService: FeedsService, feedCards:[Card]? = [], title: String? = "Home") {
        self.apiService = apiService
        self.cards = feedCards ?? []
        self.title = title ?? "Home"
    }
}


extension HomeFeedsViewModel {
    func fetchCards() {
        self.apiService.homeFeedCards { [unowned self] result in
            switch result {
            case .success(let cards):
                self.cards = cards
                return
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
}

