//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 27.09.2023.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultViewControllerDipTap(_ viewModel: TitlePreviewViewModel)
}


class SearchResultViewController: UIViewController {

    public var titles: [Title] = [Title]()
    public weak var delegate: SearchResultViewControllerDelegate?
    
    public let searchResultCollectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10 , height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(searchResultCollectionView)
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    
}
extension SearchResultViewController: ConfigureCollectionView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        let titlePosterPath = titles[indexPath.row].posterPath ?? ""
        cell.configure(with: titlePosterPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.originalTitle else { return }
        guard let titleOverview = title.overview else { return }
        APICaller.shared.getMovie(with: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.delegate?.searchResultViewControllerDipTap(TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
