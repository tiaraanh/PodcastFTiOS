//
//  HomeViewModel.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 12/11/22.
//

import UIKit

class RecommendedViewModel {
    private var recommendeds: [Recommended] = []
    
    func fetchPodcasts(q: String, completion: @escaping (Result<Void, Error>) -> Void) {
        APIService.shared.fetchPodcastsInRecommended(q: q) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let recommendeds):
                    self?.recommendeds = recommendeds
                    completion(.success(()))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    var numberOfRecommendeds: Int {
        return recommendeds.count
    }
    
    func recommendedImageUrl(at index: Int) -> String {
        return recommendeds[index].artworkUrl600
    }
    
    func recommendedTrackName(at index: Int) -> String {
        return recommendeds[index].trackName
    }
    
    func recommendedArtistName(at index: Int) -> String {
        return recommendeds[index].artistName
    }
    
    func recommendedTrackCount(at index: Int) -> String {
        return "\(recommendeds[index].trackCount) Episode(s)"
    }
    
    func recommended(at index: Int) -> Recommended {
        return recommendeds[index]
    }
}



