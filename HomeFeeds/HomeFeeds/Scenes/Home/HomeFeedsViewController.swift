//
//  HomeFeedsViewController.swift
//  HomeFeeds
//
//  Created by Andrew Ikenna Jones on 1/11/23.
//

import UIKit
import Combine

class HomeFeedsViewController: UIViewController {

    private let viewModel: HomeFeedsViewModel
    lazy var feedsView = HomeFeedsView()
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: HomeFeedsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = feedsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareView()
        bindViewModel()
        viewModel.fetchCards()
    }
    
    private func prepareView() {
        self.title = viewModel.title
        feedsView.tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.$cards
            .receive(on: RunLoop.main)
            .sink { _ in
                self.renderCards()
            }
            .store(in: &cancellables)
    }
    
    private func renderCards() {
        feedsView.tableView.reloadData()
    }
}


// MARK: TableViewDataSource Methods
extension HomeFeedsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cardCell = tableView.dequeueReusableCell(withIdentifier: "FeedCard", for: indexPath) as? FeedCardCell {
            cardCell.card = viewModel.cards[indexPath.row]
            return cardCell
        }
        return UITableViewCell()
    }
    
}
