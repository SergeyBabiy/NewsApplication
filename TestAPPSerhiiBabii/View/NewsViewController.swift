//
//  NewsViewController.swift
//  TestAPPSerhiiBabii
//
//  Created by Сергей Бабий on 14.07.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    private let urlMainImg = "https://image.tmdb.org/t/p/original"
    private let myNibName = "MyTableViewCell"
    private let cellId = "cell"
    private let buttonName = ["STORIES","VIDEO","FAVORITES"]
    private var newsInfoList = [NewsInfo]()
    private let newsPresenter = NewsFactory.getInstance().newsPresenter()
    private let navigationBarNews = UINavigationBar()
    
    private lazy var newsObserver: ([NewsInfo]?) -> Void = { newsInfoList in
        guard let list = newsInfoList else { return }
        self.newsInfoList.append(contentsOf: list)
        self.newsTableView.reloadData()
    }
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        newsTableView.register(UINib(nibName: myNibName, bundle: nil), forCellReuseIdentifier: cellId)
        customSegmentedControl()
        newsPresenter.getNews(response: newsObserver)
    }
    
    private func customSegmentedControl() {
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50), buttonTitle: buttonName)
        codeSegmented.backgroundColor = .black
        view.addSubview(codeSegmented)
    }
    
    private func setupTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MyTableViewCell
        cell.labelCell.text = newsInfoList[indexPath.row].title
        let imageUrl = newsInfoList[indexPath.row].backdropPath
        cell.imageCell.downloaded(from: "\(urlMainImg)\(imageUrl)")
        cell.activityIndicator.isHidden = true
        if indexPath.row == newsInfoList.count - 1 {
            cell.activityIndicator.isHidden = false
            newsPresenter.getNews(response: newsObserver)
        }
        return cell
    }
}
