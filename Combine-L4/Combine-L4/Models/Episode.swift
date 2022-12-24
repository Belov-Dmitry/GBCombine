//
//  Episode.swift
//  Combine-L4
//
//  Created by Dmitry Belov on 21.12.2022.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name, airDate, episode: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode
    }
}
