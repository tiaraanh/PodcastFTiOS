//
//  EpisodeViewController.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 10/11/22.
//

import UIKit

class EpisodeViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var viewModel: EpisodeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadEpisodes()
    }
    
    func setup() {
        title = viewModel.title
        
        tableView.dataSource = self
        tableView.delegate = self
        
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
    
    func loadEpisodes() {
        viewModel.loadEpisodes { [weak self] (_) in
            self?.tableView.reloadData()
        }
    }
    
    func searchEpisodes(q: String) {
        viewModel.searchEpisodes(q: q) { [weak self] (_) in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func downloadEposode(at index: Int) {
        viewModel.downloadEpisode(at: index) { [weak self] (result) in
            guard let `self` = self else { return }
            
        }
    }
}

// MARK: - UISearchBarDelegate
extension EpisodeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.count >= 3 {
            searchEpisodes(q: text)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count >= 3 {
            searchEpisodes(q: text)
        }
    }
}

// MARK: - UITableViewDataSource
extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEpisodes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCellId", for: indexPath) as! EpisodeViewCell
        
        let index = indexPath.row
        cell.numberLabel.text = String(index+1)
        cell.titleLabel.text = viewModel.episodeTitle(at: index)
        cell.artistsLabel.text = viewModel.episodeArtist(at: index)
        cell.thumbImageView.kf.setImage(with: URL(string: viewModel.episodeImagUrl(at: index))) { (result) in
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
extension EpisodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presentPlayerViewController(episode: viewModel.episode(at: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: "Download", handler: { (_, _, completion) in
            self.downloadEposode(at: indexPath.row)
            completion(true)
        })
        favorite.image = UIImage(systemName: "square.and.arrow.down.fill")
        favorite.backgroundColor = UIColor.systemGreen
        
        let actions = UISwipeActionsConfiguration(actions: [favorite])
        return actions
    }
}

extension UIViewController {
    func showEpisodeViewController(podcast: Podcast) {
        let viewController = UIStoryboard(name: "Episode", bundle: nil)
            .instantiateViewController(withIdentifier: "episode") as! EpisodeViewController
        viewController.viewModel = EpisodeViewModel(podcast: podcast)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
