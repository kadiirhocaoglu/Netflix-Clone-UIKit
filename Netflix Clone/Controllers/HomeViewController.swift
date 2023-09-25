//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 5.09.2023.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - UI Elements
    private let HomeFeedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    // MARK: - Properties
    let sectionTitles: [String] = ["Trending Movies", "Trending TV", "Popular",  "Upcoming Movies", "Top Rated"]
   
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(HomeFeedTableView)
        HomeFeedTableView.delegate = self
        HomeFeedTableView.dataSource = self
        
        configureNavbar()
        
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        HomeFeedTableView.tableHeaderView = headerView
        fecthData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        HomeFeedTableView.frame = view.bounds
    }
    
    // MARK: - Functions
    private func fecthData() {
        getTrendingMovies()
        getTrendingTv()
        getUpcoming()
        getTopRated()
        getPopular()
        
    }
    
    private func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { results in
            switch results {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func getTrendingTv() {
        APICaller.shared.getTrendingTv { results in
            switch results {
            case .success(let tvSeries):
                print(tvSeries)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func getUpcoming() {
        APICaller.shared.getUpcoming { results in
          switch results {
            case .success(let media):
                print(media)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func getTopRated() {
        APICaller.shared.getTopRated { results in
          switch results {
            case .success(let topRated):
                print(topRated)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func getPopular() {
        APICaller.shared.getPopular { results in
          switch results {
            case .success(let popular):
                print(popular)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    private func configureNavbar() {
        var image = UIImage(named: "logo_netflix")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
        
        
    }
    
 
    // MARK: - Actions

    
    
  
}
//MARK: - Extensions
extension HomeViewController: ConfigureTableView{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20 , y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
