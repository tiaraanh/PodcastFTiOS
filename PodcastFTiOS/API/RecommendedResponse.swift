//
//  RecommendedResponse.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 18/11/22.
//

import Foundation

struct RecommendedResponse: Decodable {
    let count: Int
    let results: [Recommended]
    
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        results = try container.decodeIfPresent([Recommended_].self, forKey: .results) ?? []
    }
}
