//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 5.09.2023.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case Upcoming  = 3
    case TopRated = 4
}


class HomeViewController: UIViewController {
    // MARK: - UI Elements
    private let HomeFeedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    // MARK: - Properties
    let sectionTitles: [String] = ["TRENDING MOVIES", "TRENDING TV", "POPULAR",  "UPCOMING MOVIES", "TOP RATED"]
   
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
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        HomeFeedTableView.frame = view.bounds
    }
    
    
    // MARK: - Functions
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
        switch indexPath.section {
            case Sections.TrendingMovies.rawValue:
                APICaller.shared.getTrendingMovies { results in
                switch results {
                    case .success(let titles):
                    cell.configure(with: titles  )
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.TrendingTV.rawValue:
            APICaller.shared.getTrendingTv { results in
            switch results {
                case .success(let titles):
                cell.configure(with: titles  )
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            case Sections.Popular.rawValue:
            APICaller.shared.getPopular { results in
            switch results {
                case .success(let titles):
                cell.configure(with: titles  )
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcoming { results in
            switch results {
                case .success(let titles):
                cell.configure(with: titles  )
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated { results in
            switch results {
                case .success(let titles):
                cell.configure(with: titles  )
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break
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
