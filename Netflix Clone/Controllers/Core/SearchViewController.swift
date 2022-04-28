//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Alejandro on 4/26/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles:[MovieTitle] = [MovieTitle]()
    
    let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie"
        controller.searchBar.searchBarStyle = .minimal
        
        return controller

    }()
    private let discoverTable:UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
    
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
                
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = .white
        searchController.searchBar.becomeFirstResponder()
        
        definesPresentationContext = true
        
        
        view.addSubview(discoverTable)
        discoverTable.frame = view.bounds
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        fetchDiscoverMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    private func fetchDiscoverMovies(){
        APICaller.shared.getDiscoverMovies(completion: { [weak self] result in
            
            switch result {
            case .success(let titles):
                print(titles.count)
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(String(describing: error))
            }
            
        })
    }
    
}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        print(String(describing: searchController.searchBar.text ?? ""))
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else{ return }
        print("passed")
        APICaller.shared.search(with: query) { result in
            print(result)
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let movieTitle = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (movieTitle.original_title ?? "Unknown"), posterUrl: movieTitle.poster_path))
        return cell
    }
    
    
    
}
