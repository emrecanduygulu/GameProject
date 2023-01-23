//
//  ListViewController.swift
//  GameProject
//
//  Created by emre can duygulu on 18.01.2023.
//

import UIKit

class ListViewController: UIViewController, ListViewModelOutput, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.games.count - 5 {
            guard let url = viewModel.next else { return }
            viewModel.fetchNextPage(with: url)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewSource.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel.loadGamesWithFilter(searchTerm: searchText)
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
    
    func isLoading(_ value: Bool) {
        DispatchQueue.main.async {
            if value == true {
                self.viewSource.activityIndicator.startAnimating()
            } else {
                self.viewSource.activityIndicator.stopAnimating()
            }
        }
    }
    
    private lazy var viewSource = ListView()
    
    private let viewModel = ListViewModel()
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSource.tableView.delegate = self
        viewSource.tableView.dataSource = self
        viewSource.searchBar.delegate = self
        viewModel.output = self
        title = "Home"
        viewModel.onViewDidLoad()
    }
}
