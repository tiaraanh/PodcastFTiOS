//
//  EpisodeViewModel.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 13/11/22.
//

import Foundation

class EpisodeViewModel {
    private let podcast: Podcast
    init(podcast: Podcast) {
        self.podcast = podcast
    }
    
    private var episodes: [Episode] = []
    private var filteredEpisodes: [Episode] = []
    
    var title: String {
        return podcast.trackName
    }
    
    func loadEpisodes(completion: @escaping (Result<Void, Error>) -> Void) {
        APIService.shared.fetchEpisodes(feedUrl: podcast.feedUrl) { [weak self] (result) in
            guard let safeSelf = self else { return }
            switch result {
            case .success(let episodes):
                safeSelf.episodes = episodes
                safeSelf.filteredEpisodes = episodes
                completion(.success(()))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchEpisodes(q: String, completion: (Result<Void, Error>) -> Void) {
        
    }
    
    func downloadEpisode(at index: Int, completion: (Result<Bool, Error>) -> Void) {
        
        // get episode from ... array
        let episode = episode(at: index)
        
        // save data of download episode to userDefault
        UserDefaults.standard.downloadEpisode(episode)
        
        // actual download by streamUrl
        APIService.shared.downloadEpisode(episode)
    }
}

extension EpisodeViewModel {
    var numberOfEpisodes: Int {
        return filteredEpisodes.count
    }
    
    func episodeArtist(at index: Int) -> String {
        return filteredEpisodes[index].epAuthor
    }
    
    func episodeImagUrl(at index: Int) -> String {
        return filteredEpisodes[index].imageUrl
    }
    
    func episodePubDate(at index: Int) -> String {
        let date = filteredEpisodes[index].publishDate
        return date.description
    }
    
    func episodeTitle(at index: Int) -> String {
        return filteredEpisodes[index].epTitle
    }
    
    func episodeDescription(at index: Int) -> String {
        return filteredEpisodes[index].epDescription
    }
    
    func episode(at index: Int) -> Episode {
        return filteredEpisodes[index]
    }
    
}
