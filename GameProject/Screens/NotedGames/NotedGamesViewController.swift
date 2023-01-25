//
//  NotedGamesViewController.swift
//  GameProject
//
//  Created by emre can duygulu on 25.01.2023.
//

import UIKit

class NotedGamesViewController: UIViewController, NotedGamesViewModelOutput, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CellView = tableView.dequeueReusableCell(withIdentifier: CellView.cellId, for: indexPath) as! CellView
        let game = viewModel.games[indexPath.row]
        cell.populate(with: game)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.openGameDetail(indexPath: indexPath)
    }
    
    func showData() {
        viewSource.tableView.reloadData()
    }
    
    func showError(errorMessage: String) {
        print("Error")
    }
    
    func openGameDetail(game: Result) {
        let viewController = DetailViewController(with: DetailViewModel(gameId: game.id ?? 4))
        show(viewController, sender: nil)
    }
    
    private lazy var viewSource = NotedGamesView()
    
    private let viewModel = NotedGamesViewModel()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = viewSource
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSource.tableView.delegate = self
        viewSource.tableView.dataSource = self
        viewModel.output = self
        title = "noted_games".localized()
        
    }
}
