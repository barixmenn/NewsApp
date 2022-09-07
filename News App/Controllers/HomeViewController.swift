//
//  ViewController.swift
//  News App
//
//  Created by Baris on 6.09.2022.
//

import UIKit
import SafariServices



class HomeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    //MARK: -UI Elements
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    //MARK: -Properties
    private var articles = [Article]()
    private var viewModels = [NewsTableViewCellViewModel]()
    
    
    //MARK: -Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Properties
        view.addSubview(tableView)
        
        //TableView source
        tableView.delegate = self
        tableView.dataSource = self
        
        //NavigationBar title and view background
        title = "News"
        view.backgroundColor = .systemBackground
        
        
        //MARK: -API GET DATA
        APICaller.shared.getTopStories { [weak self] results in
            switch results {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, subtitle: $0.description, imageURL: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    
    //MARK: -TableView
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { fatalError()}
            
        cell.configure(with: viewModels[indexPath.row])
        print(cell)
        

        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let articles = articles[indexPath.row]
        
        guard let url = URL(string: articles.url ?? "") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    


}


