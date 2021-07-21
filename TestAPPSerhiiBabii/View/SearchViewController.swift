//
//  SearchViewController.swift
//  TestAPPSerhiiBabii
//
//  Created by Сергей Бабий on 16.07.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchCell = "searchCell"
    private let searchNibName = "SearchTableViewCell"
    private let searchPresenter = NewsFactory.getInstance().searchPresenter()
    private var searchList: [SearchInfo]? = nil
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var backButton: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        table.register(UINib(nibName: searchNibName, bundle: nil), forCellReuseIdentifier: searchCell)
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: searchCell)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: searchCell, for: indexPath) as! SearchTableViewCell
        cell.titleLanelCell.text = searchList?[indexPath.row].name
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.searchPresenter.search(query: searchText) { (searchList) in
                guard let searchList = searchList else { return }
                self.searchList = searchList
                self.table.reloadData()
            }
        })
    }
}
