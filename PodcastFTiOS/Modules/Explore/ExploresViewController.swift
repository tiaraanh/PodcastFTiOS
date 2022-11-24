//
//  ExploresViewController.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 16/11/22.
//

import UIKit
import Kingfisher

class ExploresViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchTime: Timer?
    
    let viewModel = ExploresViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
//        title = "Explores"
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
    
    func searchPodcasts(q: String) {
        searchTime?.invalidate()
        searchTime = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (timer) in
            self?.viewModel.searchPodcasts(q: q) { [weak self] (result) in
                self?.tableView.reloadData()
            }
        })
    }
}

// MARK: - UISearchBarDelegate
extension ExploresViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.count >= 3 {
            searchPodcasts(q: text)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count >= 3 {
            searchPodcasts(q: text)
        }
    }
}

// MARK: - UITableViewDataSource
extension ExploresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPodcasts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exploresCellId", for: indexPath) as! ExploresViewCell
        
        let index = indexPath.row
        cell.nameLabel.text = viewModel.podcastTrackName(at: index)
        cell.artistLabel.text = viewModel.podcastArtistName(at: index)
        cell.thumbImageView.kf.setImage(with: URL(string: viewModel.podcastImagUrl(at: index))) { (result) in
            switch result {
            case.success:
                cell.thumbImageView.contentMode = .scaleAspectFill
            case .failure:
                cell.thumbImageView.contentMode = .center
                cell.thumbImageView.image = UIImage(systemName: "photo")
            }
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ExploresViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        showEpisodeViewController(podcast: viewModel.podcast(at: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let index = indexPath.row
        let isFavorited = viewModel.isFavorited(at: index)
        let title = isFavorited ? "Unfavorite" : "Favorite"
        
        let favorite = UIContextualAction(style: .normal, title: title, handler: { (_, _, completion) in
            if isFavorited {
                self.viewModel.deleteFavorite(at: index)
            }
            else {
                self.viewModel.addToFavorite(at: index)
            }
            completion(true)
        })
        
        if isFavorited {
            favorite.image = UIImage(systemName: "star.slash.fill")
            favorite.backgroundColor = UIColor.systemRed
        }
        else {
            favorite.image = UIImage(systemName: "star.fill")
            favorite.backgroundColor = UIColor.systemYellow
        }
        
        let actions = UISwipeActionsConfiguration(actions: [favorite])
        return actions
    }
}
