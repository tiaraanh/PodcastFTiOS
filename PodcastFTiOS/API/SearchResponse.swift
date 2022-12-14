

import Foundation

struct SearchResponse: Decodable {
    let count: Int
    let results: [Podcast]
    let resultRecommended: [Recommended]
    let resultCollections: [Collections]
    
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        results = try container.decodeIfPresent([Podcast_].self, forKey: .results) ?? []
        resultRecommended = try container.decodeIfPresent([Recommended_].self, forKey: .results) ?? []
        resultCollections = try container.decodeIfPresent([Collections_].self, forKey: .results) ?? []
    }
}
