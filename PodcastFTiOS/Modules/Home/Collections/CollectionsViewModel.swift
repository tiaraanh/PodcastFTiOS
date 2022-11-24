

import UIKit

class CollectionsViewModel {
    private var collections: [Collections] = []
    let dateFormatterEx = Date()
    
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
    
    func collectionsReleaseDate(at index: Int) -> String {
        let resultDate = "\(collections[index].releaseDate)"
        let dateFormatIso = dateFormatterEx.formatIso(input: resultDate)
        let formatter = dateFormatterEx.dateFormatter(format: "yyyy-MM-dd", input: dateFormatIso)
        
        let result = formatter.stringDateFormatter(format: "MMMM, d yyyy")
        
        return "\(result)"
    }
    
    func collections(at index: Int) -> Collections {
        return collections[index]
    }
    
}

extension CollectionsViewModel: ManagedObjectContextGetter { }

