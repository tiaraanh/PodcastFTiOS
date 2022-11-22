

import UIKit

class CollectionsViewModel {
    private var collections: [Collections] = []
    
    func fetchPodcasts(q: String, completion: @escaping (Result<Void, Error>) -> Void) {
        APIService.shared.fetchPodcastsInCollections(q: q) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let collections):
                    self?.collections = collections
                    completion(.success(()))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    var numberOfCollections: Int {
        return collections.count
    }
    
    func collectionsImageUrl(at index: Int) -> String {
        return collections[index].artworkUrl100
    }
    
    func collectionsTrackName(at index: Int) -> String {
        return collections[index].trackName
    }
    
    func collectionsArtistName(at index: Int) -> String {
        return collections[index].artistName
    }
    
    func collectionsReleaseDate(at index: Int) -> String {
        return collections[index].releaseDate
    }
    
    func collections(at index: Int) -> Collections {
        return collections[index]
    }
    
}

extension CollectionsViewModel: ManagedObjectContextGetter { }

