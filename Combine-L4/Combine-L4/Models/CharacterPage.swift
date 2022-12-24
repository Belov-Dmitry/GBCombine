//
//  CharacterPage.swift
//  Combine-L4
//
//  Created by Dmitry Belov on 13.12.2022.
//

import Foundation

public struct CharacterPage: Codable {
    public var info: PageInfo
    public var results: [Character]

    public init(info: PageInfo, results: [Character]) {
        self.info = info
        self.results = results
    }
}
